import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Piso {
  final String nombre;
  final String descripcion;
  final String idParqueo;

  Piso(this.nombre, this.descripcion, this.idParqueo);
}

class CreatePisoScreen extends StatelessWidget {
  static const routeName = '/vista-piso';

  final String idParqueo;

  CreatePisoScreen({required this.idParqueo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Formulario de Piso'),
          backgroundColor: const Color.fromARGB(255, 5, 126, 225),
        ),
        body: PisoListScreen(idParqueo: idParqueo,),
      ),
    );
  }
}

class PisoListScreen extends StatefulWidget {
  final String idParqueo;
  
  PisoListScreen({required this.idParqueo});

  @override
  _PisoListScreenState createState() => _PisoListScreenState();
}

class _PisoListScreenState extends State<PisoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pisos'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ... otros widgets ...

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgregarPisoScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: const Text('Agregar Piso'),
            ),
          ],
        ),
      ),
    );
  }
}

class AgregarPisoScreen extends StatefulWidget {
  @override
  _AgregarPisoScreenState createState() => _AgregarPisoScreenState();
}

class _AgregarPisoScreenState extends State<AgregarPisoScreen> {
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Nombre del Piso"),
            TextFormField(
              controller: nombreController,
              decoration: InputDecoration(
                hintText: "Ingrese el nombre del piso",
              ),
            ),
            SizedBox(height: 20.0),

            Text("Descripción del Piso"),
            TextFormField(
              controller: descripcionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Ingrese la descripción del piso",
              ),
            ),
            SizedBox(height: 20.0),

            

            ElevatedButton(
              onPressed: () async{
                // Aquí puedes implementar la lógica para agregar un nuevo piso
                // utilizando los datos ingresados en los controladores.
                Map<String, dynamic> data = {
                  'nombre': nombreController.text,
                  'descripcion': descripcionController.text

                };

                await(agregarPiso(data, 'ID-PARQUEO-3'));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: const Text('Agregar Piso'),
            ),
          ],
        ),
      ),
    );
  }
}


Future<void> agregarPiso(Map<String, dynamic> datos, String idParqueo) async {

  try {
    // Obtén una referencia a la colección 'pisos' dentro de un parqueo específico
    CollectionReference pisosCollection = FirebaseFirestore.instance
        .collection('parqueo') // Cambia 'parqueo' al nombre de tu colección de parqueos
        .doc(idParqueo) // Cambia 'ID-DEL-PARQUEO' al ID del parqueo específico
        .collection('pisos');

    // Agrega un nuevo documento a la colección 'pisos' con los datos proporcionados
    await pisosCollection.add(datos);
  } catch (e) {
    print('Error al agregar el piso: $e');
  }

}


