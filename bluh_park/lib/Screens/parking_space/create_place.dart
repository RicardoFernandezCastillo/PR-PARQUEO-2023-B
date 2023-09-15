import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Plaza {
  final String nombre;
  final bool tieneCobertura;
  final String idPlaza;
  Plaza(this.nombre, this.tieneCobertura,this.idPlaza);
}

class CreatePlaceScreen extends StatelessWidget {
  static const routeName = '/create-place-srceen';

  const CreatePlaceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Formulario de Plaza'),
          backgroundColor: const Color.fromARGB(255, 5, 126, 225),
        ),
        body: PlazaListScreen(),
      ),
    );
  }
}

class PlazaListScreen extends StatefulWidget {
  const PlazaListScreen({super.key});

  @override
  _PlazaListScreenState createState() => _PlazaListScreenState();
}

class _PlazaListScreenState extends State<PlazaListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Plazas'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: obtenerPlazasStream('ID-PARQUEO-3', 'ID-PISO-1', 'ID-FILA-1'),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Obtén la lista de plazas
            List<Plaza> plazas =
                snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              String idDocumento = document.id; // Obtener el ID del documento
              return Plaza(data['nombre'], data['tieneCobertura'], idDocumento);
            }).toList();

          return ListView.builder(
            itemCount: plazas.length,
            itemBuilder: (context, index) {
              final plaza = plazas[index];
              return InkWell(
                onTap: () {
                  // Aquí puedes definir la acción que se realizará al hacer clic en el elemento.
                  // Por ejemplo, puedes abrir una pantalla de detalles de la plaza.
                  //abrirDetallesPlaza(plaza);
                },
                child: ListTile(
                  title: Text(plaza.nombre),
                  subtitle: Text(
                      plaza.tieneCobertura ? 'Con Cobertura' : 'Sin Cobertura'),
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
                              builder: (context) => EditarPlazaScreen(idPlaza:plaza.idPlaza),
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
            MaterialPageRoute(builder: (context) => AgregarPlazaScreen()),
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

class AgregarPlazaScreen extends StatefulWidget {
  @override
  _AgregarPlazaScreen createState() => _AgregarPlazaScreen();
}

class _AgregarPlazaScreen extends State<AgregarPlazaScreen> {
  String nombre = '';
  String tipoVehiculo = '';
  bool tieneCobertura = false;
  String pisoYFila = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nueva Plaza'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre',
                fillColor: Colors.blue,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  nombre = val;
                });
              },
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
              decoration: const InputDecoration(
                labelText: 'Piso y Fila',
                fillColor: Colors.blue,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  pisoYFila = val;
                });
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> datos = {
                  'nombre': nombre, // Nombre de la plaza
                  'tipoVehiculo': tipoVehiculo, // Tipo de vehículo permitido
                  'tieneCobertura':
                      tieneCobertura, // Indica si tiene cobertura o no
                  'piso_fila': pisoYFila, // Piso y Fila
                  // Puedes agregar otros campos según tus necesidades
                };
                // Llama a la función para agregar el documento a la subcolección
                await agregarDocumentoASubcoleccion(
                    'IDParqueo', 'IDPiso', 'IDFila', datos);
                // Crea una nueva Plaza y devuelve los datos a la pantalla anterior.
                Navigator.pop(
                  context
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: const Text('Agregar Plaza'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditarPlazaScreen extends StatefulWidget {
  final String idPlaza; // Recibe el ID de la plaza

  EditarPlazaScreen({required this.idPlaza});

  @override
  _EditarPlazaScreenState createState() => _EditarPlazaScreenState();
}

class _EditarPlazaScreenState extends State<EditarPlazaScreen> {
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
          .doc(widget.idPlaza) // Usa el ID de la plaza pasado como argumento
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
                    widget.idPlaza,
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

/*
class ParqueoForm extends StatefulWidget {
  const ParqueoForm({super.key});

  @override
  _ParqueoFormState createState() => _ParqueoFormState();
}

class _ParqueoFormState extends State<ParqueoForm> {
  String nombre = '';
  String tipoVehiculo = '';
  bool tieneCobertura = false;
  String pisoYFila = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nombre',
              fillColor: Colors.blue,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
            ),
            onChanged: (val) {
              setState(() {
                nombre = val;
              });
            },
          ),
          const SizedBox(height: 20.0),
          Container(alignment: Alignment.topLeft,child: const Text('Tipo de Vehículo', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),),
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
          Container(alignment: Alignment.topLeft,child: const Text('¿Tiene Cobertura?', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold))),
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
            decoration: const InputDecoration(
              labelText: 'Piso y Fila',
              fillColor: Colors.blue,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
            ),
            onChanged: (val) {
              setState(() {
                pisoYFila = val;
              });
            },
            
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async{
              // Aquí puedes manejar la lógica para enviar el formulario o guardar los datos.
                Map<String, dynamic> datos = {
                  'nombre': nombre, // Nombre de la plaza
                  'tipoVehiculo': tipoVehiculo, // Tipo de vehículo permitido
                  'tieneCobertura': tieneCobertura, // Indica si tiene cobertura o no
                  'Piso y Fila': pisoYFila, // Piso y Fila
                  // Puedes agregar otros campos según tus necesidades
                };
                // Llama a la función para agregar el documento a la subcolección
                await agregarDocumentoASubcoleccion('IDParqueo', 'IDPiso', 'IDFila', datos);
            },
            style: ElevatedButton.styleFrom(primary: Colors.blue),
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }
}


*/
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
    print('Error al obtener el Stream de plazas: $e');
    throw e;
  }
}
