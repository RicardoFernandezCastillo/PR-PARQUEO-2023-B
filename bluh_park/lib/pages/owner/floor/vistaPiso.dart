import 'dart:developer';

import 'package:bluehpark/models/to_use/parking.dart';
import 'package:bluehpark/pages/owner/seccion/seccion_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreatePisoScreen extends StatelessWidget {
  static const routeName = '/vista-piso';

  final DocumentReference idParqueo;

  const CreatePisoScreen({super.key, required this.idParqueo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Formulario de Piso'),
          backgroundColor: const Color.fromARGB(255, 5, 126, 225),
              leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
          )
        ),
        body: PisoListScreen(
          idParqueo: idParqueo,
        ),
      ),
    );
  }
}

class PisoListScreen extends StatefulWidget {
  final DocumentReference idParqueo;

  PisoListScreen({required this.idParqueo});

  @override
  _PisoListScreenState createState() => _PisoListScreenState();
}

class _PisoListScreenState extends State<PisoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getPisos(widget.idParqueo),
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
          List<Piso> pisos =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Piso(
                idPiso: document.reference,
                nombre: data['nombre'],
                descripcion: data['descripcion']);
          }).toList();
          return ListView.builder(
            itemCount: pisos.length,
            itemBuilder: (context, index) {
              final piso = pisos[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SeccionList(pisoRef: piso.idPiso),
                    ),
                  );
                  // Implementa aquí la lógica que se realizará al hacer clic en el elemento.
                  // Por ejemplo, puedes abrir una pantalla de detalles de la plaza.
                },
                child: Card(
                  elevation: 3.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(
                      piso.nombre,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      piso.descripcion,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.car_repair, color: Colors.blue),
                      onPressed: () {
                        // DataReservationSearch dataSearch = DataReservationSearch(idParqueo: parqueo.idParqueo);
                        // // Implementa aquí la lógica para abrir la pantalla de edición.
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MostrarDatosParqueoScreen(dataSearch: dataSearch)
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AgregarPisoScreen(idParqueo: widget.idParqueo),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AgregarPisoScreen extends StatefulWidget {
  final DocumentReference idParqueo;
  const AgregarPisoScreen({super.key, required this.idParqueo});

  @override
  AgregarPisoScreenState createState() => AgregarPisoScreenState();
}

class AgregarPisoScreenState extends State<AgregarPisoScreen> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nuevo Piso'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Nombre del Piso"),
            TextFormField(
              controller: nombreController,
              decoration: const InputDecoration(
                hintText: "Ingrese el nombre del piso",
              ),
            ),
            const SizedBox(height: 20.0),
            const Text("Descripción del Piso"),
            TextFormField(
              controller: descripcionController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Ingrese la descripción del piso",
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                // Aquí puedes implementar la lógica para agregar un nuevo piso
                // utilizando los datos ingresados en los controladores.
                Map<String, dynamic> data = {
                  'nombre': nombreController.text,
                  'descripcion': descripcionController.text
                };

                await (agregarPiso(data, widget.idParqueo));
                if (!context.mounted) return;
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Agregar Piso'),
            ),
          ],
        ),
      ),
    );
  }
}

Stream<QuerySnapshot> getPisos(DocumentReference parqueoRef) {
  try {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference pisosCollection = parqueoRef.collection('pisos');
      return pisosCollection.snapshots();
      // Filtra los documentos donde el campo 'IdDuenio' sea igual al user.uid
    } else {
      // Si el usuario no ha iniciado sesión, aún puedes devolver un Stream vacío o manejarlo de otra manera.
      return const Stream<QuerySnapshot>.empty();
    }
  } catch (e) {
    log('Error al obtener el Stream de parqueos: $e');
    rethrow;
  }
}

Future<void> agregarPiso(
    Map<String, dynamic> datos, DocumentReference idParqueo) async {
  try {
    // Obtén una referencia a la colección 'pisos' dentro de un parqueo específico
    CollectionReference pisosCollection = idParqueo.collection('pisos');

    // Agrega un nuevo documento a la colección 'pisos' con los datos proporcionados
    await pisosCollection.add(datos);
  } catch (e) {
    log('Error al agregar el piso: $e');
  }
}
