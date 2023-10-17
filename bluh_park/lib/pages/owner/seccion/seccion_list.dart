import 'package:bluehpark/models/seccion_class.dart';
import 'package:bluehpark/pages/owner/seccion/seccion_edit.dart';
import 'package:bluehpark/services/fb_service_secccion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(const SeccionList());

// ignore: must_be_immutable
class SeccionList extends StatefulWidget {
  const SeccionList({super.key});

  @override
  State<SeccionList> createState() => _SeccionListState();
}

class _SeccionListState extends State<SeccionList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        title: 'Bluh Park',
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Lista de Secciones',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            backgroundColor: Colors.blue,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Parqueo',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Agrega aquí la lógica para la acción del botón "Nuevo"
                        Navigator.pushNamed(context, '/seccion/create');
                      },
                      child: const Text('Nuevo'),
                    ),
                  ],
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: getSeccionsStream("ID-PARQUEO-3", "ID-PISO-1"),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      List<Seccion> seccions =
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        String idDocumento = document.id;
                        return Seccion(
                            idDocumento, data['nombre'], data['descripcion']);
                      }).toList();
                      return ListView.builder(
                        itemCount: seccions.length,
                        itemBuilder: (context, index) {
                          final seccion = seccions[index];
                          return InkWell(
                            onTap: () {
                              // Aquí puedes definir la acción que se realizará al hacer clic en el elemento.
                              // Por ejemplo, puedes abrir una pantalla de detalles de la plaza.
                              //abrirDetallesPlaza(plaza);
                            },
                            child: ListTile(
                              title: Text(seccion.name),
                              subtitle: Text(seccion.description),
                              leading: CircleAvatar(
                                child: Text(seccion.name[0]),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // Abrir la pantalla de edición
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SeccionEdit(
                                        idSeccion: seccion.idSeccion,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
