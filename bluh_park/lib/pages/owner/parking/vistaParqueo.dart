import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../floor/vistaPiso.dart';

import '../../../Models/Parqueo.dart';

 

class Plaza {

  final String nombre;

  final bool tieneCobertura;

  final String idPlaza;

  Plaza(this.nombre, this.tieneCobertura,this.idPlaza);

}

 

class CreateParqueoScreen extends StatelessWidget {

  static const routeName = '/vista-parqueo';



  const CreateParqueoScreen({super.key});

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      home: Scaffold(

        appBar: AppBar(

          title: const Text('Formulario de Parqueo'),

          backgroundColor: const Color.fromARGB(255, 5, 126, 225),

        ),

        body: ParqueoListScreen(),

      ),

    );

  }

}

 

class ParqueoListScreen extends StatefulWidget {

  const ParqueoListScreen({super.key});

 

  @override

  _ParqueoListScreenState createState() => _ParqueoListScreenState();

}

 

class _ParqueoListScreenState extends State<ParqueoListScreen> {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('Lista de Parqueos'),

        backgroundColor: Colors.blue,

      ),

      body: StreamBuilder(
        
        stream: obtenerParqueosStream(),

        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {

            return CircularProgressIndicator();

          }

 

          if (snapshot.hasError) {

            return Text('Error: ${snapshot.error}');

          }

 

          // Obtén la lista de Parqueos

            List<Parqueo> parqueos =

                snapshot.data!.docs.map((DocumentSnapshot document) {

              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

              String idDocumento = document.id; // Obtener el ID del documento

              return Parqueo(idDocumento, data['nombre'], data['direccion'], data['ubicacion'],
                             data['tieneCobertura'], data['descripcion'], data['vehiculosPermitidos'], data['nit'],
                             data['tarifaMoto'], data['tarifaAutomovil'], data['tarifaOtro'], 
                             data['horaApertura'], data['horaCierre'], data['idDuenio']);
                              


            }).toList();

 

          return ListView.builder(

            itemCount: parqueos.length,

            itemBuilder: (context, index) {

              final parqueo = parqueos[index];

              return InkWell(

                onTap: () {

                  // Aquí puedes definir la acción que se realizará al hacer clic en el elemento.

                  // Por ejemplo, puedes abrir una pantalla de detalles de la plaza.

                  //abrirDetallesPlaza(plaza);
                  Navigator.push(

                    context,

                    MaterialPageRoute(

                    builder: (context) => CreatePisoScreen(idParqueo:parqueo.idParqueo),

                    ),

                  );

                },
                
                

                child: ListTile(

                  title: Text(parqueo.nombre),

                  subtitle: Text(

                      parqueo.tieneCobertura ? 'Con Cobertura' : 'Sin Cobertura'),

                  trailing: Row(

                    mainAxisSize: MainAxisSize.min,

                    children: [

                      IconButton(

                        icon: const Icon(Icons.edit),

                        onPressed: () {

                          // Implementa aquí la lógica para abrir la pantalla de edición.

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (context) => EditarParqueoScreen(idParqueo:parqueo.idParqueo),

                            ),

                          );

                        },

                      ),

                    ],

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

            MaterialPageRoute(builder: (context) => AgregarParqueoScreen()),

          );

        },

        backgroundColor: Colors.blue,

        child: const Icon(Icons.add),

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

 

class AgregarParqueoScreen extends StatefulWidget {

  @override

  _AgregarParqueoScreen createState() => _AgregarParqueoScreen();

}

 

class _AgregarParqueoScreen extends State<AgregarParqueoScreen> {

 TextEditingController nombreController = TextEditingController();

 TextEditingController direccionController = TextEditingController();

 TextEditingController latitudController = TextEditingController();

 TextEditingController longitudController = TextEditingController();

 bool? tieneCoberturaController;

 TextEditingController descripcionController = TextEditingController();

 Map<String, bool>? vehiculosPermitidosController;

 TextEditingController nitController = TextEditingController();

 Map<String, double>? tarifaMotoController;

 Map<String, double>? tarifaAutomovilController;

 Map<String, double>? tarifaOtroController;

 TextEditingController horaAperturaController = TextEditingController();

 TextEditingController horaCierreController = TextEditingController();
 
 TextEditingController motoHoraController = TextEditingController();
 TextEditingController motoDiaController = TextEditingController();
 TextEditingController automovilHoraController = TextEditingController();
 TextEditingController automovilDiaController = TextEditingController();
 TextEditingController otroHoraController = TextEditingController();
 TextEditingController otroDiaController = TextEditingController();

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('Agregar Nuevo Parqueo'),

        backgroundColor: Colors.blue,

      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Input de texto para el nombre del parqueo
            Text("1. Nombre del Parqueo"),
            
            TextFormField(
              controller: nombreController,
              decoration: InputDecoration(
                hintText: "Ingrese el nombre del parqueo",
              ),
            ),
            SizedBox(height: 20.0),

            // Input de texto para la dirección del parqueo
            Text("2. Dirección del Parqueo"),
            TextFormField(
              controller: direccionController,
              decoration: InputDecoration(
                hintText: "Ingrese la dirección del parqueo",
              ),
            ),
            SizedBox(height: 20.0),

            // Input de texto para la latitud y longitud
            Text("3. Coordenadas"),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: latitudController,
                    decoration: InputDecoration(
                      hintText: "Latitud",
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    controller: longitudController,
                    decoration: InputDecoration(
                      hintText: "Longitud",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),

            // Switch para "Cuenta con cubierta"
            Text("4. Cuenta con cubierta"),
            Row(
              children: [
                Text("No"),
                Switch(
                  value: true,
                  onChanged: (value) {
                    setState(() {
                      //vehiculoSeleccionado = value ? "Sí" : "No";
                    });
                  },
                ),
                Text("Sí"),
              ],
            ),
            SizedBox(height: 20.0),

            // Input de texto grande para la descripción del parqueo
            Text("5. Descripción del Parqueo"),
            TextFormField(
              controller: descripcionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Ingrese la descripción del parqueo",
              ),
            ),
            SizedBox(height: 20.0),

            // Título "Vehículos permitidos"
            Text("6. Vehículos permitidos"),
            //Row(
            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //  children: [
            //    Radio(
            //      value: "Autos",
            //      groupValue: vehiculoSeleccionado,
            //      onChanged: (value) {
            //        setState(() {
            //          vehiculoSeleccionado = value;
            //        });
            //      },
            //    ),
            //    Text("Autos"),
            //    Radio(
            //      value: "Motos",
            //      groupValue: vehiculoSeleccionado,
            //      onChanged: (value) {
            //        setState(() {
            //          vehiculoSeleccionado = value;
            //        });
            //      },
            //    ),
            //    Text("Motos"),
            //    Radio(
            //      value: "Mixto",
            //      groupValue: vehiculoSeleccionado,
            //      onChanged: (value) {
            //        setState(() {
            //          vehiculoSeleccionado = value;
            //        });
            //      },
            //    ),
            //    Text("Mixto"),
            //  ],
            //),
            SizedBox(height: 20.0),

            // Input de texto para el NIT del propietario
            Text("7. NIT del Propietario"),
            TextFormField(
              controller: nitController,
              decoration: InputDecoration(
                hintText: "Ingrese el NIT del propietario",
              ),
            ),
            SizedBox(height: 20.0),

            // Tarifas de auto y moto
            Text("8. Tarifas"),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Autos: hora/"),
                      TextFormField(
                        controller: automovilHoraController,
                        decoration: InputDecoration(
                          hintText: "Ingrese tarifa por hora",
                        ),
                      ),
                      Text("Bs. - día/"),
                      TextFormField(
                        controller: automovilDiaController,
                        decoration: InputDecoration(
                          hintText: "Ingrese tarifa por día",
                        ),
                      ),
                      Text("Bs."),
                    ],
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Motos: hora/"),
                      TextFormField(
                        controller: motoHoraController,
                        decoration: InputDecoration(
                          hintText: "Ingrese tarifa por hora",
                        ),
                      ),
                      Text("Bs. - día/"),
                      TextFormField(
                        controller: motoDiaController,
                        decoration: InputDecoration(
                          hintText: "Ingrese tarifa por día",
                        ),
                      ),
                      Text("Bs."),
                    ],
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Otros: hora/"),
                      TextFormField(
                        controller: otroHoraController,
                        decoration: InputDecoration(
                          hintText: "Ingrese tarifa por hora",
                        ),
                      ),
                      Text("Bs. - día/"),
                      TextFormField(
                        controller: otroDiaController,
                        decoration: InputDecoration(
                          hintText: "Ingrese tarifa por día",
                        ),
                      ),
                      Text("Bs."),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),

            // Input de texto para la hora de apertura y cierre
            Text("9. Horario de Apertura y Cierre"),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: horaAperturaController,
                    decoration: InputDecoration(
                      hintText: "Hora de Apertura",
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    controller: horaCierreController,
                    decoration: InputDecoration(
                      hintText: "Hora de Cierre",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async{
                GeoPoint ubicacion = GeoPoint(double.parse(latitudController.text), double.parse(longitudController.text));
                Map<String, bool> vhp = {'Autos': true, 'Motos': true, 'Otros':false};
                Map<String,double> tarifaMoto = {'Dia': double.parse(motoDiaController.text), 'Hora':double.parse(motoHoraController.text)};
                Map<String,double> tarifaAutomovil = {'Dia': double.parse(automovilDiaController.text), 'Hora':double.parse(automovilHoraController.text)};
                Map<String,double> tarifaOtro = {'Dia': double.parse(otroDiaController.text), 'Hora':double.parse(otroHoraController.text)};
                Map<String, dynamic> data = {
                  'nombre': nombreController.text,
                  'direccion' : direccionController.text,
                  'ubicacion': ubicacion,
                  'tieneCobertura': true,
                  'descripcion': descripcionController.text, 
                  'vehiculosPermitidos': vhp , 
                  'nit': nitController.text,
                  'tarifaMoto': tarifaMoto, 
                  'tarifaAutomovil': tarifaAutomovil, 
                  'tarifaOtro': tarifaOtro, 
                  'horaApertura': horaAperturaController.text, 
                  'horaCierre': horaCierreController.text, 
                  'idDuenio': 'DoxhZory2ye1bg0R5XxzoyePMMX2'
                };
              

                await agregarParqueo(data);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 23, 131, 255), // Color de fondo azul
                onPrimary: Colors.white, // Color del texto en blanco
                padding: EdgeInsets.all(16.0),
              ),
              child: Text("Registrar"),
            ),
          ],
        ),
      ),
      );

  }

}

 

class EditarParqueoScreen extends StatefulWidget {

  final String idParqueo; // Recibe el ID de la plaza

 

  EditarParqueoScreen({required this.idParqueo});

 

  @override

  _EditarParqueoScreenState createState() => _EditarParqueoScreenState();

}

 

class _EditarParqueoScreenState extends State<EditarParqueoScreen> {

  TextEditingController nombreController = TextEditingController();

  TextEditingController pisoYFilaController = TextEditingController();

 

  String tipoVehiculo = '';

  bool tieneCobertura = false;

 

  @override

  void initState() {

    super.initState();

    cargarDatosPlaza(); // Carga los datos de la plaza en initState

  }

 

  Future<void> cargarDatosPlaza() async {

    try {

      // Usa el ID de la plaza para obtener los datos desde Firestore

      DocumentSnapshot<Map<String, dynamic>> plazaDoc = await FirebaseFirestore

          .instance

          .collection('parqueo')

          .doc('ID-PARQUEO-3')

          .collection('pisos')

          .doc('ID-PISO-1')

          .collection('filas')

          .doc('ID-FILA-1')

          .collection('plazas')

          .doc(widget.idParqueo) // Usa el ID de la plaza pasado como argumento

          .get();

 

      if (plazaDoc.exists) {

        Map<String, dynamic> data = plazaDoc.data() as Map<String, dynamic>;

        setState(() {

          nombreController.text = data['nombre'];

          tipoVehiculo = data['tipoVehiculo'];

          tieneCobertura = data['tieneCobertura'];

          pisoYFilaController.text = data['piso_fila'];

        });

      }

    } catch (e) {

      print('Error al cargar los datos de la plaza: $e');

    }

  }

 

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('Editar Plaza'),

        backgroundColor: Colors.blue,

      ),

      body: Padding(

        padding: const EdgeInsets.all(16.0),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[

            TextFormField(

              controller: nombreController,

              decoration: const InputDecoration(

                labelText: 'Nombre',

                fillColor: Colors.blue,

                focusedBorder: OutlineInputBorder(

                  borderSide: BorderSide(color: Colors.blue, width: 2.0),

                ),

              ),// Establece el valor inicial desde Firestore

            ),

            const SizedBox(height: 20.0),

            Container(

              alignment: Alignment.topLeft,

              child: const Text(

                'Tipo de Vehículo',

                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),

              ),

            ),

            Row(

              children: <Widget>[

                Radio(

                  value: 'Moto',

                  groupValue: tipoVehiculo,

                  onChanged: (val) {

                    setState(() {

                      tipoVehiculo = val!;

                    });

                  },

                ),

                const Text('Moto'),

                Radio(

                  value: 'Automóvil',

                  groupValue: tipoVehiculo,

                  onChanged: (val) {

                    setState(() {

                      tipoVehiculo = val!;

                    });

                  },

                ),

                const Text('Automóvil'),

                Radio(

                  value: 'Otro',

                  groupValue: tipoVehiculo,

                  onChanged: (val) {

                    setState(() {

                      tipoVehiculo = val!;

                    });

                  },

                ),

                const Text('Otro'),

              ],

            ),

            const SizedBox(height: 20.0),

            Container(

                alignment: Alignment.topLeft,

                child: const Text('¿Tiene Cobertura?',

                    style: TextStyle(

                        fontSize: 16.0, fontWeight: FontWeight.bold))),

            Row(

              children: <Widget>[

                Radio(

                  value: true,

                  groupValue: tieneCobertura,

                  onChanged: (val) {

                    setState(() {

                      tieneCobertura = val!;

                    });

                  },

                ),

                const Text('Sí'),

                Radio(

                  value: false,

                  groupValue: tieneCobertura,

                  onChanged: (val) {

                    setState(() {

                      tieneCobertura = val!;

                    });

                  },

                ),

                const Text('No'),

              ],

            ),

            const SizedBox(height: 20.0),

            TextFormField(

              controller: pisoYFilaController,

              decoration: const InputDecoration(

                labelText: 'Piso y Fila',

                fillColor: Colors.blue,

                focusedBorder: OutlineInputBorder(

                  borderSide: BorderSide(color: Colors.blue, width: 2.0),

                ),

              ) // Establece el valor inicial desde Firestore

            ),

            const SizedBox(height: 20.0),

            ElevatedButton(

              onPressed: () async {

                Map<String, dynamic> datos = {

                  'nombre': nombreController.text, // Nombre de la plaza

                  'tipoVehiculo': tipoVehiculo, // Tipo de vehículo permitido

                  'tieneCobertura':

                      tieneCobertura, // Indica si tiene cobertura o no

                  'piso_Fila': pisoYFilaController.text, // Piso y Fila

                  // Puedes agregar otros campos según tus necesidades

                };

                // Llama a la función para actualizar el documento en Firestore

                await editarPlaza(

                    'ID-PARQUEO-3',

                    'ID-PISO-1',

                    'ID-FILA-1',

                    widget.idParqueo,

                    datos); // Usa el ID de la plaza pasado como argumento

                // Regresa a la pantalla anterior con los datos actualizados

                Navigator.pop(

                  context //Se puede enviar Un objeto plaza

                );

              },

              style: ElevatedButton.styleFrom(primary: Colors.blue),

              child: const Text('Guardar Cambios'),

            ),

          ],

        ),

      ),

    );

  }

}


Future<void> agregarParqueo(Map<String, dynamic> datos) async {

  // Obtén una referencia a la colección principal, en este caso, 'parqueos'

  CollectionReference parqueos =

      FirebaseFirestore.instance.collection('parqueo');

  // Obtén una referencia al documento del parqueo
  

  
  await parqueos.doc().set(datos);

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

    await plazaDocRef.update(datos); // Utiliza update para modificar campos existentes o set con merge: true

  } catch (e) {

    print('Error al editar la plaza: $e');

  }

}

 

Future<List<Plaza>> getPlaces(

    String idParqueo, String idPiso, String idFila) async {

  try {

    CollectionReference plazasCollection = FirebaseFirestore.instance

        .collection('parqueo')

        .doc(idParqueo)

        .collection('pisos')

        .doc(idPiso)

        .collection('filas')

        .doc(idFila)

        .collection('plazas');

 

    QuerySnapshot querySnapshot = await plazasCollection.get();

 

    // Mapea los documentos en objetos de la clase Plaza

    List<Plaza> plazas = querySnapshot.docs.map((DocumentSnapshot document) {

      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      return Plaza(data['nombre'], data['tieneCobertura'],document.id);

    }).toList();

 

    return plazas;

  } catch (e) {

    print('Error al obtener las plazas: $e');

    return [];

  }

}

 

Stream<QuerySnapshot> obtenerParqueosStream() {

  try {

    CollectionReference parqueosCollection = FirebaseFirestore.instance
        .collection('parqueo');

    return parqueosCollection

        .snapshots(); // Devuelve un Stream que escucha cambios en la colección.

  } catch (e) {

    print('Error al obtener el Stream de plazas: $e');

    throw e;

  }

}

 

