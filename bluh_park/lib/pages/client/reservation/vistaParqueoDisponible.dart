import 'dart:developer';
import 'package:bluehpark/models/Parqueo.dart';
import 'package:bluehpark/models/to_use/parking.dart';
import 'package:bluehpark/pages/client/reservation/search_parking_spaces.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class ParqueoDisponibleListScreen extends StatefulWidget {

    const ParqueoDisponibleListScreen({super.key});
    static const routeName = '/vista-parqueoDisponible';
  
   
  
    @override
  
    _ParqueoDisponibleListScreenState createState() => _ParqueoDisponibleListScreenState();
  
  }
  
   
  
  class _ParqueoDisponibleListScreenState extends State<ParqueoDisponibleListScreen> {
  
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
                    // Navigator.push(
  
                    //   context,
  
                    //   MaterialPageRoute(
  
                    //   builder: (context) => MostrarDatosParqueoScreen(idParqueo:parqueo.idParqueo),
  
                    //   ),
  
                    // );
  
                  },
                  
                  
  
                  child: ListTile(
  
                    title: Text(parqueo.nombre),
  
                    subtitle: Text(
  
                        parqueo.direccion),
  
                    
  
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
  

  final DataReservationSearch dataSearch; // Recibe el ID de la plaza
  const MostrarDatosParqueoScreen({super.key, required this.dataSearch});

  @override
  State<MostrarDatosParqueoScreen> createState() => _MostrarDatosParqueoScreenState();
}

class _MostrarDatosParqueoScreenState extends State<MostrarDatosParqueoScreen> {
  TextEditingController nombreParqueoController = TextEditingController();
  TextEditingController horaAperturaController = TextEditingController();
  TextEditingController horaCierreController = TextEditingController();
  TextEditingController tarifaAutomovilControllerHora = TextEditingController();
  TextEditingController tarifaAutomovilControllerdia = TextEditingController();
  TextEditingController tarifaMotoControllerHora = TextEditingController();
  TextEditingController tarifaMotoControllerDia = TextEditingController();
  TextEditingController tarifaOtrosControllerHora = TextEditingController();
  TextEditingController tarifaOtrosControllerDia = TextEditingController();

  Map<String, bool>? vehiculosPermitidosMap;
  Map<String, dynamic>? tarifaAutomovilMap;
  Map<String, dynamic>? tarifaMotoMap;
  Map<String, dynamic>? tarifaOtrosMap;
  bool radioValue = false;
  Timestamp? timeHoraApertura;
  Timestamp? timeHoraCierre;

  List<DateTime?> selectedDate = [null, null];

  bool? tieneCobertura;
  String? coberturaTexto;

  @override
  void initState() {
    super.initState();
    cargarDatosParqueo();
  }

  Future<void> cargarDatosParqueo() async {
    try {

      DocumentReference parqueoRef = widget.dataSearch.idParqueo;
      DocumentSnapshot<Map<String, dynamic>> plazaDoc =
          await parqueoRef.get() as DocumentSnapshot<Map<String, dynamic>>;

      if (plazaDoc.exists) {
        Map<String, dynamic> data = plazaDoc.data() as Map<String, dynamic>;

        setState(() {
          nombreParqueoController.text = data['nombre'];
          horaAperturaController.text = data['horaApertura']?.toString() ?? '';
          horaCierreController.text = data['horaCierre']?.toString() ?? '';

          timeHoraApertura = data['horaApertura'];
          timeHoraCierre = data['horaCierre'];

          selectedDate[0] = timeHoraApertura?.toDate();
          selectedDate[1] = timeHoraCierre?.toDate();

          tieneCobertura = data['tieneCobertura'];

          tarifaAutomovilControllerHora.text =
              "Hora " + data['tarifaAutomovil']['Hora'].toString() + ' Bs';

          tarifaAutomovilControllerdia.text =
              "Dia " + data['tarifaAutomovil']['Dia'].toString() + ' Bs';

          tarifaMotoControllerHora.text =
              "Hora " + data['tarifaMoto']['Hora'].toString() + ' Bs';

          tarifaMotoControllerDia.text =
              "Dia " + data['tarifaMoto']['Dia'].toString() + ' Bs';

          tarifaOtrosControllerHora.text =
              "Hora " + data['tarifaOtro']['Hora'].toString() + ' Bs';

          tarifaOtrosControllerDia.text =
              "Dia " + data['tarifaOtro']['Dia'].toString() + ' Bs';

          if (tieneCobertura == true) {
            coberturaTexto = "Cuenta con cobertura";
          } else {
            coberturaTexto = "No cuenta con cobertura";
          }
        });
      }
    } catch (e) {
      log('Error al cargar los datos de la plaza: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/img_parqueo.jpg',
                    width: size.width * 0.7,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 158, 195, 213),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: nombreParqueoController,
                      readOnly: true,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Urbanist',
                      ),
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(220, 217, 217, 217),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Vehiculos Permitidos',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IgnorePointer(
                                ignoring:
                                    true, // Esto hace que los Checkbox sean de solo lectura
                                child: Radio(
                                  groupValue: 'permitidos',
                                  value: true,
                                  onChanged: null,
                                  activeColor: Colors
                                      .blueAccent, // Pasar null a onChanged deshabilita la interacción
                                ),
                              ),
                              Text('Motos'),
                              IgnorePointer(
                                ignoring: true,
                                child: Radio(
                                  groupValue: 'permitidos',
                                  value: false,
                                  onChanged: null,
                                ),
                              ),
                              Text('Automoviles'),
                              IgnorePointer(
                                ignoring: false,
                                child: Radio(
                                  groupValue: 'permitidos',
                                  value: false,
                                  onChanged: null,
                                ),
                              ),
                              Text(
                                'Otros',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(220, 217, 217, 217),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Calificacion',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  index < 5 ? Icons.star : Icons.star_border,
                                  color: Colors.yellow[600],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(220, 217, 217, 217),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cobertura',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              IgnorePointer(
                                ignoring: true,
                                child: Row(
                                  children: <Widget>[
                                    Radio<bool>(
                                      value: true,
                                      groupValue: radioValue,
                                      onChanged:
                                          null, // Establece onChanged a null para deshabilitar la interacción
                                    ),
                                    const Text('Sí'),
                                  ],
                                ),
                              ),
                              IgnorePointer(
                                ignoring: true,
                                child: Row(
                                  children: <Widget>[
                                    Radio<bool>(
                                      value: false,
                                      groupValue: radioValue,
                                      onChanged: null,
                                      // Establece onChanged a null para deshabilitar la interacción
                                    ),
                                    const Text('No'),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(220, 217, 217, 217),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Horarios',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InkWell(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Horario Apertura',
                                        style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          color: Colors.blueAccent,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons
                                              .calendar_today), // Ícono de calendario
                                          const SizedBox(
                                              width:
                                                  8), // Espacio entre el ícono y el texto
                                          Text(
                                            selectedDate[0] != null
                                                ? DateFormat('dd/MM/yyyy HH:mm')
                                                    .format(selectedDate[0]!)
                                                : '',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Horario Cierre',
                                        style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          color: Colors.blueAccent,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons
                                              .calendar_today), // Ícono de calendario
                                          const SizedBox(
                                              width:
                                                  8), // Espacio entre el ícono y el texto
                                          Text(
                                            selectedDate[1] != null
                                                ? DateFormat('dd/MM/yyyy HH:mm')
                                                    .format(selectedDate[0]!)
                                                : '',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(220, 217, 217, 217),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "9. Tarifas",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.only(top: 20, left: 10),
                            child: Text(
                              'Autos',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: tarifaAutomovilControllerHora,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    // Ajusta estos valores según tus necesidades
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: tarifaAutomovilControllerdia,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    // Ajusta estos valores según tus necesidades
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.only(top: 20, left: 10),
                            child: Text(
                              'Motos',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: tarifaMotoControllerHora,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    // Ajusta estos valores según tus necesidades
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: tarifaMotoControllerDia,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    // Ajusta estos valores según tus necesidades
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.only(top: 20, left: 10),
                            child: Text(
                              'Otros',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: tarifaOtrosControllerHora,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    // Ajusta estos valores según tus necesidades
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: tarifaOtrosControllerDia,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    // Ajusta estos valores según tus necesidades
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ), // Ajusta el radio para hacerlo semi redondeado
                  ), // Cambia el color de fondo del botón
                ),
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => ParkingSpaces(dataSearch:widget.dataSearch),
                      ),
  
                    );
                },
                child: const Text('Ingresar'),
              ),
            ],
          ),
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
