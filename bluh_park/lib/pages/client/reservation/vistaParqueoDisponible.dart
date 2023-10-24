import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../../Models/Parqueo.dart';


class ParqueoDisponibleListScreen extends StatefulWidget {

    const ParqueoDisponibleListScreen({super.key});
    static const routeName = '/vista-parqueoDisponible';
    @override
  
    ParqueoDisponibleListScreenState createState() => ParqueoDisponibleListScreenState();
  
  }
  
  class ParqueoDisponibleListScreenState extends State<ParqueoDisponibleListScreen> {
  
    @override
  
    Widget build(BuildContext context) {
  
      return Scaffold(
  
        appBar: AppBar(
  
          title: const Text('Parqueos disponibles en tu zona'),
  
          backgroundColor: Colors.blue,
  
        ),
  
        body: StreamBuilder(
          
          stream: obtenerParqueosStream(),
  
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  
            if (snapshot.connectionState == ConnectionState.waiting) {
  
              return const CircularProgressIndicator();
  
            }
  
   
  
            if (snapshot.hasError) {
  
              return Text('Error: ${snapshot.error}');
  
            }
  
   
  
            // Obtén la lista de Parqueos
  
              List<ParqueoPrueba> parqueos =
  
                  snapshot.data!.docs.map((DocumentSnapshot document) {
  
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  
                //String idDocumento = document.id; // Obtener el ID del documento
                DocumentReference idDocumento = document.reference;
  
                return ParqueoPrueba(idDocumento , data['nombre'], data['direccion'], data['ubicacion'],
                               data['tieneCobertura'], data['descripcion'], data['vehiculosPermitidos'], data['nit'],
                               data['tarifaMoto'], data['tarifaAutomovil'], data['tarifaOtro'], 
                               data['horaApertura'].toString(), data['horaCierre'].toString(), data['idDuenio']);
                                
  
  
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
  
                      builder: (context) => MostrarDatosParqueoScreen(idParqueo:parqueo.idParqueo),
  
                      ),
  
                    );
  
                  },
                  
                  
  
                  child: ListTile(
  
                    title: Text(parqueo.nombre),
  
                    subtitle: Text(
  
                        parqueo.tieneCobertura ? 'Con Cobertura' : 'Sin Cobertura'),
  
                    
  
                  ),
  
                );
  
              },
  
            );
  
          },
  
        ),
  
  
      );
  
    }
  
  }
  Stream<QuerySnapshot> obtenerParqueosStream() {

    try {
  
      CollectionReference parqueosCollection = FirebaseFirestore.instance
          .collection('parqueo');
      return parqueosCollection
  
          .snapshots(); // Devuelve un Stream que escucha cambios en la colección.
  
    } catch (e) {
  
      log('Error al obtener el Stream de plazas: $e');
  
      rethrow;
  
    }
  
  }

class MostrarDatosParqueoScreen extends StatefulWidget {
  

  final DocumentReference idParqueo; // Recibe el ID de la plaza
  MostrarDatosParqueoScreen({required this.idParqueo});

  @override
  State<MostrarDatosParqueoScreen> createState() => _MostrarDatosParqueoScreenState();
}

class _MostrarDatosParqueoScreenState extends State<MostrarDatosParqueoScreen> {
  TextEditingController nombreParqueoController = TextEditingController();
  TextEditingController horaAperturaController = TextEditingController();
  TextEditingController horaCierreController = TextEditingController();
  TextEditingController tarifaAutomovilController = TextEditingController();

  Map<String, bool>? vehiculosPermitidosMap;
  Map<String, dynamic>? tarifaAutomovilMap;

  @override
  void initState() {
    super.initState();
    cargarDatosParqueo();
  }

  Future<void> cargarDatosParqueo() async {
    try {
      DocumentReference parqueoRef = widget.idParqueo;
      DocumentSnapshot<Map<String, dynamic>> plazaDoc =
          await parqueoRef.get() as DocumentSnapshot<Map<String, dynamic>>;

      if (plazaDoc.exists) {
        Map<String, dynamic> data = plazaDoc.data() as Map<String, dynamic>;

        setState(() {
          nombreParqueoController.text = data['nombre'];
          horaAperturaController.text = data['horaApertura']?.toString() ?? '';
          horaCierreController.text = data['horaCierre']?.toString() ?? '';

         
          tarifaAutomovilMap = data['tarifaAutomovil'] as Map<String, dynamic>?;
          if (tarifaAutomovilMap != null) {
            tarifaAutomovilController.text =
                'Automóviles: Hora/${tarifaAutomovilMap!['Hora'] ?? '-'}bs Día/${tarifaAutomovilMap!['Dia'] ?? '-'}bs';
          }
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
        backgroundColor: const Color.fromARGB(255, 5, 126, 225),
        title: Text(
          nombreParqueoController.text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Grupo de 3 radio buttons
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'Autos',
                  groupValue: null,
                  onChanged: null,
                ),
                Text('Autos'),
                Radio(
                  value: 'Motos',
                  groupValue: null,
                  onChanged: null,
                ),
                Text('Motos'),
                Radio(
                  value: 'Mixto',
                  groupValue: null,
                  onChanged: null,
                ),
                Text('Mixto'),
              ],
            ),

            // Fila de 5 estrellas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Icon(
                  index < 5 ? Icons.star : Icons.star_border,
                  color: Colors.yellow,
                ),
              ),
            ),

            // Fila de Horario
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Horario:'),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hora Apertura:'),
                    Text(horaAperturaController.text),
                  ],
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hora Cierre:'),
                    Text(horaCierreController.text),
                  ],
                ),
              ],
            ),

            // Cuadro de texto medio amplio
            const SizedBox(height: 20.0),
            const Text(
              'Texto Medio Amplio:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tarifas'),
                Text(tarifaAutomovilController.text),
              ],
            ),
          ],
        ),
      ),
    );
  }
}















// class InterfazLectura extends StatelessWidget {
//   final int calificacion;
//   final String horaApertura;
//   final String horaCierre;
//   final String textoLargo;

//   InterfazLectura({
//     required this.calificacion,
//     required this.horaApertura,
//     required this.horaCierre,
//     required this.textoLargo,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Interfaz de Lectura',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Grupo de 3 radio buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Radio(
//                   value: 'Autos',
//                   groupValue: null,
//                   onChanged: null,
//                 ),
//                 Text('Autos'),
//                 Radio(
//                   value: 'Motos',
//                   groupValue: null,
//                   onChanged: null,
//                 ),
//                 Text('Motos'),
//                 Radio(
//                   value: 'Mixto',
//                   groupValue: null,
//                   onChanged: null,
//                 ),
//                 Text('Mixto'),
//               ],
//             ),

//             // Fila de 5 estrellas
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 5,
//                 (index) => Icon(
//                   index < calificacion ? Icons.star : Icons.star_border,
//                   color: Colors.yellow,
//                 ),
//               ),
//             ),

//             // Fila de Horario
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Horario:'),
//                 SizedBox(width: 10.0),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Hora Apertura:'),
//                     Text(horaApertura),
//                   ],
//                 ),
//                 SizedBox(width: 20.0),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Hora Cierre:'),
//                     Text(horaCierre),
//                   ],
//                 ),
//               ],
//             ),

//             // Cuadro de texto medio amplio
//             SizedBox(height: 20.0),
//             Text(
//               'Texto Medio Amplio:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10.0),
//             Container(
//               padding: EdgeInsets.all(10.0),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//               child: Text(
//                 textoLargo,
//                 style: TextStyle(fontSize: 16.0),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
