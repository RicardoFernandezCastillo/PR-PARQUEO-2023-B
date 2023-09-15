import 'package:bluh_park/services/fb_service_secccion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//void main() => runApp(SeccionEdit( ));

// ignore: must_be_immutable
class SeccionEdit extends StatefulWidget {
  String idSeccion;
  SeccionEdit({super.key, required this.idSeccion});

  @override
  State<SeccionEdit> createState() => _SeccionEditState();
}

class _SeccionEditState extends State<SeccionEdit> {
  //text controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();

    getSeccion(); // Carga los datos de la plaza en initState
  }

  Future<void> getSeccion() async {
    try {
      // Usa el ID de la plaza para obtener los datos desde Firestore
      DocumentSnapshot<Map<String, dynamic>> plazaDoc = await FirebaseFirestore
          .instance
          .collection('parqueo')
          .doc('ID-PARQUEO-3')
          .collection('pisos')
          .doc('ID-PISO-1')
          .collection('filas')
          .doc(widget.idSeccion) // Usa el ID de la plaza pasado como argumento
          .get();

      if (plazaDoc.exists) {
        Map<String, dynamic> data = plazaDoc.data() as Map<String, dynamic>;

        setState(() {
          nameController.text = data['nombre'];

          descriptionController.text = data['descripcion'];
        });
      }
    } catch (e) {
      print('Error al cargar los datos de la plaza: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        title: 'Material App',
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Crear nueva Sección',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            backgroundColor: Colors.blue,
          ),
          body: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Nombre de la Sección',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Descripción de la Sección',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descripción',
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Respond to button press
                    Map<String, dynamic> datos = {
                      'nombre': nameController.text,
                      'descripcion': descriptionController.text,
                    };
                    editSeccion(
                        "ID-PARQUEO-3", "ID-PISO-1", widget.idSeccion, datos);
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: const Text('Guardar',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ],
            ),
          ),
        ));
  }
}
