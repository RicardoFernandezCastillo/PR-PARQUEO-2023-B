import 'package:bluehpark/models/Parking.dart';
import 'package:bluehpark/services/fb_service_map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class MapClient extends StatefulWidget {
  const MapClient({super.key});

  @override
  State<MapClient> createState() => _MapClientState();
}

class _MapClientState extends State<MapClient> {
  final MapController mapController = MapController();
  final Location location = Location();
  LatLng userLocation = const LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    try {
      final currentLocation = await location.getLocation();
      setState(() {
        userLocation =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        mapController.move(userLocation, 16.0);
      });
    } catch (e) {
      print('Error obteniendo la ubicación: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Todos los Parqueos',
            style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getAllParkings(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          List<Parking> parkings =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Parking(
                idParking: document.id,
                name: data['nombre'],
                description: data['descripcion'],
                direccion: data['direccion'],
                ubicacion: data['ubicacion'],
                tieneCobertura: data['tieneCobertura'],
                vehiculosPermitidos: data['vehiculosPermitidos'],
                nit: data['nit'],
                tarifaMoto: data['tarifaMoto'],
                tarifaAutomovil: data['tarifaAutomovil'],
                tarifaOtro: data['tarifaOtro'],
                horaApertura: data['horaApertura'],
                horaCierre: data['horaCierre'],
                idDuenio: data['idDuenio']);
          }).toList();

          return FlutterMap(
            mapController: mapController,
            options: const MapOptions(
              initialCenter: LatLng(-17.396843874763828, -66.16765210043515),
              initialZoom: 16,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/{z}/{x}/{y}@2x?access_token={accessToken}',
                additionalOptions: const {
                  'accessToken':
                      'sk.eyJ1IjoiYml4dGVyIiwiYSI6ImNsbnRtbmo1cTA1YzUybHNhdXVsa216MnUifQ.k6u6YazVmA54rDwoLRDC2Q',
                },
              ),
              MarkerLayer(
                markers: [
                  Marker(
                      width: 80.0,
                      height: 80.0,
                      point: userLocation, // Ubicación actual del usuario
                      child: IconButton(
                        icon: const Icon(Icons.location_on),
                        color: Colors.blue,
                        iconSize: 45,
                        onPressed: () {},
                      )),
                  ...parkings.map((parking) {
                    return Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(
                        parking.ubicacion.latitude,
                        parking.ubicacion.longitude,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.car_repair),
                        color: Colors.blue,
                        iconSize: 45,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ItenDetail(
                                  parking.name,
                                  parking.description,
                                  parking.direccion,
                                  parking.horaApertura,
                                  parking.horaCierre,
                                  parking.tieneCobertura,
                                  parking.vehiculosPermitidos);
                            },
                          );
                        },
                      ),
                    );
                  }).toList()
                ],
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              mapController.move(userLocation, 16.0);
              // Centra el mapa en la ubicación del usuario con un zoom de 16.0
            },
            child: const Icon(Icons.location_on),
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              mapController.move(
                  mapController.center, mapController.zoom + 1.0);
              // Hace zoom en el mapa
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              mapController.move(
                  mapController.center, mapController.zoom - 1.0);
              // Hace zoom out en el mapa
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

Widget ItenDetail(
    String name,
    String description,
    String direccion,
    Timestamp horaApertura,
    Timestamp horaCierre,
    bool tieneCobertura,
    Map<String, dynamic> vehiculosPermitidos) {
  const style = TextStyle(fontSize: 16);
  DateFormat formatter = DateFormat('HH:mm');
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Card(
      margin: const EdgeInsets.all(3),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/paking.jpg',
                      width: 250,
                      height: 150,
                    ),
                  ],
                )),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(description, style: style),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(description, style: style),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Colors.blueGrey,
                        ),
                        Text(
                          'Hora Apertura: ${formatter.format(horaApertura.toDate())}',
                          style: style,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.timer_off,
                          color: Colors.blueGrey,
                        ),
                        Text(
                          //Optener la hora de un timestamp
                          'Hora Cierrre: ${formatter.format(horaCierre.toDate())}',
                          style: style,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.paragliding,
                          color: Colors.blueGrey,
                        ),
                        Text(
                          //Optener la hora de un timestamp
                          'Cobertura: ${tieneCobertura ? 'SI' : 'NO'}',
                          style: style,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Veiculos Permitidos:',
                      style: style,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.car_crash,
                          color: Colors.blueGrey,
                        ),
                        Icon(Icons.motorcycle, color: Colors.blueGrey),
                        Icon(Icons.train, color: Colors.blueGrey)
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            color: Colors.blue,
            elevation: 6,
            child: const Text(
              'Reservar',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ),
  );
}

List<Widget> mostrarVehiculos(Map<String, dynamic> vehiculosPermitidos) {
  const style = TextStyle(fontSize: 16);
  return vehiculosPermitidos.entries.map((veiculo) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          '${veiculo.key}:',
          style: style,
        ),
        Text(
          'Veiculos: ${veiculo.value ? 'si' : 'no'}',
          style: style,
        ),
      ],
    );
  }).toList();
}
