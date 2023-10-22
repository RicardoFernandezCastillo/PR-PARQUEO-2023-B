import 'dart:developer';
import 'package:bluehpark/models/to_use/parking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectSpaceScreen extends StatelessWidget {
  static const routeName = '/enable-parking';

  const SelectSpaceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Plazas Disponibles'),
            backgroundColor: const Color.fromARGB(255, 5, 126, 225)),
        body: const PlazaListScreen(),
      ),
    );
  }
}

class PlazaListScreen extends StatefulWidget {
  const PlazaListScreen({super.key});

  @override
  PlazaListScreenState createState() => PlazaListScreenState();
}

class PlazaListScreenState extends State<PlazaListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getSpaces(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Obtén la lista de plazas
          List<Plaza> plazas =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;// Obtener el ID del documento
            return Plaza(
                idPlaza: document.reference,
                nombre: data['nombre'],
                tieneCobertura: data['tieneCobertura'],
                estado: data['estado'],);
          }).toList();

          return ListView.builder(
            itemCount: plazas.length,
            itemBuilder: (context, index) {
              final plaza = plazas[index];
              return InkWell(
                onTap: () {
                  // Implementa aquí la lógica que se realizará al hacer clic en el elemento.
                  // Por ejemplo, puedes abrir una pantalla de detalles de la plaza.
                },
                child: Card(
                  elevation: 3.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(
                      plaza.nombre,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      plaza.tieneCobertura
                          ? 'Con Cobertura'
                          : 'Sin Cobertura',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // Implementa aquí la lógica para abrir la pantalla de edición.
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         EditarPlazaScreen(idPlaza: parqueo.idPlaza),
                        //   ),
                        // );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Función para abrir detalles de la plaza
  void abrirDetallesPlaza(Plaza plaza) {
    // Implementa aquí la lógica para mostrar los detalles de la plaza.
    // Puedes navegar a una nueva pantalla de detalles, por ejemplo.
  }

  // // Función para editar la plaza
  // void editarPlaza(Plaza plaza) {
  //   // Implementa aquí la lógica para editar la plaza.
  //   // Puedes navegar a la pantalla de edición y pasar la plaza como argumento.
  // }
}


Future<void> agregarDocumentoASubcoleccion(String idParqueo, String idPiso,
    String idFila, Map<String, dynamic> datos) async {
  // Obtén una referencia a la colección principal, en este caso, 'parqueos'
  CollectionReference parqueos =
      FirebaseFirestore.instance.collection('parqueo');
  // Obtén una referencia al documento del parqueo
  DocumentReference parqueoDocRef = parqueos.doc("ID-PARQUEO-3");
  // Obtén una referencia a la subcolección 'pisos' dentro del documento del parqueo
  CollectionReference pisos = parqueoDocRef.collection('pisos');
  // Obtén una referencia al documento del piso
  DocumentReference pisoDocRef = pisos.doc('ID-PISO-1');
  // Obtén una referencia a la subcolección 'filas' dentro del documento del piso
  CollectionReference filas = pisoDocRef.collection('filas');
  // Obtén una referencia al documento de la fila
  DocumentReference filaDocRef = filas.doc('ID-FILA-1');
  // Obtén una referencia a la subcolección 'plazas' dentro del documento de la fila
  CollectionReference plazasCollection = filaDocRef.collection('plazas');
  // Usa set para agregar el documento con los datos proporcionados
  await plazasCollection.doc().set(datos);
}

Future<void> editarPlaza(String idParqueo, String idPiso, String idFila,
    String idPlaza, Map<String, dynamic> datos) async {
  try {
    // Obtén una referencia al documento de la plaza que deseas editar
    DocumentReference plazaDocRef = FirebaseFirestore.instance
        .collection('parqueo')
        .doc(idParqueo)
        .collection('pisos')
        .doc(idPiso)
        .collection('filas')
        .doc(idFila)
        .collection('plazas')
        .doc(idPlaza);

    // Utiliza update para modificar campos existentes o set con merge: true para combinar datos nuevos con los existentes
    await plazaDocRef.update(
        datos); // Utiliza update para modificar campos existentes o set con merge: true
  } catch (e) {
    print('Error al editar la plaza: $e');
  }
}


Stream<QuerySnapshot> obtenerPlazasStream(
    String idParqueo, String idPiso, String idFila) {
  try {
    CollectionReference plazasCollection = FirebaseFirestore.instance
        .collection('parqueo')
        .doc(idParqueo)
        .collection('pisos')
        .doc(idPiso)
        .collection('filas')
        .doc(idFila)
        .collection('plazas');
    return plazasCollection
        .snapshots(); // Devuelve un Stream que escucha cambios en la colección.
  } catch (e) {
    log('log: Error al obtener el Stream de plazas: $e');
    rethrow;
  }
}

Stream<QuerySnapshot> getParking() {
  try {
    CollectionReference parkingCollection =
        FirebaseFirestore.instance.collection('parqueo');
    return parkingCollection
        .snapshots(); // Devuelve un Stream que escucha cambios en la colección.
  } catch (e) {
    log('Error al obtener el Stream de parqueos: $e');
    rethrow;
  }
}

Stream<List<Plaza>> getSpacesRealTime() {
  // Inicializa Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  return firestore
      .collection('parqueo') // Colección principal
      .doc('ID-PARQUEO-3') // ID del documento de parqueo actual
      .collection('piso') // Subcolección piso
      .snapshots() // Escucha cambios en la colección de pisos
      .asyncMap((pisoQuerySnapshot) async {
        List<Plaza> spaces = [];

        // Recorre los documentos de 'piso'
        for (QueryDocumentSnapshot pisoDocument in pisoQuerySnapshot.docs) {
          // Realiza la consulta en la colección 'fila' dentro de cada 'piso'
          QuerySnapshot filaQuerySnapshot = await firestore
              .collection('parqueo') // Colección principal
              .doc('ID-PARQUEO-3') // ID del documento de parqueo actual
              .collection('piso') // Subcolección piso
              .doc(pisoDocument.id) // ID del documento de piso actual
              .collection('fila') // Subcolección fila
              .get();

          // Recorre los documentos de 'fila'
          for (QueryDocumentSnapshot filaDocument in filaQuerySnapshot.docs) {
            // Realiza la consulta en la colección 'plaza' dentro de cada 'fila'
            QuerySnapshot plazaQuerySnapshot = await firestore
                .collection('parqueo') // Colección principal
                .doc('ID-PARQUEO-3') // ID del documento de parqueo actual
                .collection('piso') // Subcolección piso
                .doc(pisoDocument.id) // ID del documento de piso actual
                .collection('fila') // Subcolección fila
                .doc(filaDocument.id) // ID del documento de fila actual
                .collection('plaza') // Subcolección plaza
                .where('estado', isEqualTo: 'Disponible') // Condición de búsqueda
                .get();

            // Recorre los documentos resultantes de 'plaza' para la 'fila' actual
            for (QueryDocumentSnapshot plazaDocument in plazaQuerySnapshot.docs) {
              // Accede a la información de la 'plaza'
              Map<String, dynamic> plazaData =
                  plazaDocument.data() as Map<String, dynamic>;
            }
          }
        }

        return spaces;
      });
}



Stream<QuerySnapshot> getSpaces() async* {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot pisoQuerySnapshot = await firestore
      .collection('parqueo')
      .doc('ID-PARQUEO-3')
      .collection('pisos')
      .get();

  for (QueryDocumentSnapshot pisoDocument in pisoQuerySnapshot.docs) {
    Map<String, dynamic> pisoData = pisoDocument.data() as Map<String, dynamic>;

    QuerySnapshot filaQuerySnapshot = await firestore
        .collection('parqueo')
        .doc('ID-PARQUEO-3')
        .collection('pisos')
        .doc(pisoDocument.id)
        .collection('filas')
        .get();

    for (QueryDocumentSnapshot filaDocument in filaQuerySnapshot.docs) {
      Map<String, dynamic> filaData =
          filaDocument.data() as Map<String, dynamic>;

      // Utiliza 'snapshots' para escuchar cambios en tiempo real
      Stream<QuerySnapshot> plazaQuerySnapshot = firestore
          .collection('parqueo')
          .doc('ID-PARQUEO-3')
          .collection('pisos')
          .doc(pisoDocument.id)
          .collection('filas')
          .doc(filaDocument.id)
          .collection('plazas')
          .where('estado', isEqualTo: 'disponible').where('tieneCobertura', isEqualTo: true).where('tipoVehiculo', isEqualTo: 'Automóvil')
          .snapshots();

      // Utiliza 'async* {}' para emitir los resultados en el Stream
      await for (QuerySnapshot snapshot in plazaQuerySnapshot) {
        // Aquí emite el QuerySnapshot de las plazas que pasaron el filtrado
        yield snapshot;
      }
    }
  }
}
