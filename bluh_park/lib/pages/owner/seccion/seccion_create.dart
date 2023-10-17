import 'package:bluehpark/services/fb_service_secccion.dart';
import 'package:flutter/material.dart';

void main() => runApp(const SeccionCreate());

class SeccionCreate extends StatefulWidget {
  const SeccionCreate({super.key});

  @override
  State<SeccionCreate> createState() => _SeccionCreateState();
}

class _SeccionCreateState extends State<SeccionCreate> {
  //text controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
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
                    createDocumentoASubcoleccion(
                        "ID-PARQUEO-3", "ID-PISO-1", datos);
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
