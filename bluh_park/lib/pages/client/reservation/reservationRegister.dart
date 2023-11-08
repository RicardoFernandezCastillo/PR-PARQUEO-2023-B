import 'dart:developer';

import 'package:bluehpark/models/coleccion/collection_field.dart';
import 'package:bluehpark/models/coleccion/collections.dart';
import 'package:bluehpark/models/to_use/parking.dart';
import 'package:bluehpark/models/user.dart';
import 'package:bluehpark/pages/client/home_client_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

class ReservaRegisterScreen extends StatefulWidget {
  final DataReservationSearch dataSearch;
  const ReservaRegisterScreen({super.key, required this.dataSearch});

  @override
  ReservaRegisterScreenState createState() => ReservaRegisterScreenState();
}

class ReservaRegisterScreenState extends State<ReservaRegisterScreen> {
  TextEditingController nombreParqueo = TextEditingController();
  TextEditingController pisoController = TextEditingController();
  TextEditingController filaController = TextEditingController();
  TextEditingController plazaController = TextEditingController();
  TextEditingController placaController = TextEditingController();
  TextEditingController marcaController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController modeloController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController fechaFinController = TextEditingController();

  DateTime? reservationDateIn, reservationDateOut;
  bool radioValue = false;
  List<bool> checkboxValues = [false, false, false];
  String typeVehicle = "";

  @override
  void initState() {
    super.initState();
    getDataReservation();
  }

  Future<void> _selectDateAndTimeInitial(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: reservationDateIn ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
  }

  Future<void> getDataReservation() async {
    try {
      /*DocumentSnapshot<Map<String, dynamic>> parqueoDoc =
          await widget.dataSearch.idParqueo.get()
              as DocumentSnapshot<Map<String, dynamic>>;*/

      DocumentSnapshot plazaDoc = await widget.dataSearch.idPlaza!.get();

      Map<String, dynamic> dataPlace = plazaDoc.data() as Map<String, dynamic>;

      DocumentSnapshot filaDoc =
          await widget.dataSearch.idPlaza!.parent.parent!.get();

      Map<String, dynamic> dataFila = filaDoc.data() as Map<String, dynamic>;

      DocumentSnapshot pisoDoc =
          await widget.dataSearch.idPlaza!.parent.parent!.parent.parent!.get();

      Map<String, dynamic> dataPiso = pisoDoc.data() as Map<String, dynamic>;

      DocumentSnapshot parkingDoc = await widget.dataSearch.idParqueo.get();

      Map<String, dynamic> dataParking =
          parkingDoc.data() as Map<String, dynamic>;

      nombreParqueo.text = dataParking['nombre'];

      pisoController.text = dataPiso['nombre'];
      filaController.text = dataFila['nombre'];
      plazaController.text = widget.dataSearch.plaza!;
      typeVehicle = widget.dataSearch.tipoVehiculo!;
      if (widget.dataSearch.tipoVehiculo == "Moto") {
        checkboxValues[0] = true;
      } else if (widget.dataSearch.tipoVehiculo == "Automóvil") {
        checkboxValues[1] = true;
      } else if (widget.dataSearch.tipoVehiculo == "Otro") {
        checkboxValues[2] = true;
      }
      estadoController.text = dataPlace['estado'];
      // placaController.text = dataReserve['vehiculo']['placa'];
      // marcaController.text = dataReserve['vehiculo']['marca'];
      // colorController.text = dataReserve['vehiculo']['color'];
      // modeloController.text = dataReserve['vehiculo']['modelo'];
      radioValue = widget.dataSearch.tieneCobertura!;
      Timestamp timestampDateOut = widget.dataSearch.fechaFin!;
      reservationDateOut = timestampDateOut.toDate();
      Timestamp timestampDateIn = widget.dataSearch.fechaInicio!;
      reservationDateIn = timestampDateIn.toDate();
      // setState(() {
      fechaInicioController.text =
          DateFormat('dd/MM/yyyy HH:mm a').format(reservationDateIn!);
      fechaFinController.text =
          DateFormat('dd/MM/yyyy HH:mm a').format(reservationDateOut!);
      // });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Detalles Reserva',
          style: TextStyle(fontSize: 25),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
          iconSize: 35,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 35),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/img_parqueo.jpg',
                    width: 215,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              padding: const EdgeInsets.all(15),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 50,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        readOnly: true,
                        controller: nombreParqueo,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Urbanist',
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets
                              .zero, // Elimina el relleno interior del TextField
                          border: InputBorder
                              .none, // Elimina el borde predeterminado
                          focusedBorder:
                              InputBorder.none, // Elimina el borde de enfoque
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(220, 217, 217, 217),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ubicacion',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text("Piso: "),
                                        Expanded(
                                          child: TextField(
                                            readOnly: true,
                                            controller: pisoController,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Urbanist',
                                            ),
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text("Fila: "),
                                        Expanded(
                                          child: TextField(
                                            readOnly: true,
                                            controller: filaController,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Urbanist',
                                            ),
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text("Plaza: "),
                                        Expanded(
                                          child: TextField(
                                            readOnly: true,
                                            controller: plazaController,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Urbanist',
                                            ),
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(220, 217, 217, 217),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Vehiculo',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IgnorePointer(
                                  ignoring:
                                      true, // Esto hace que los Checkbox sean de solo lectura
                                  child: Radio(
                                    value: typeVehicle,
                                    groupValue: typeVehicle,
                                    onChanged: (val) {
                                      setState(() {
                                        typeVehicle = val!;
                                      });
                                    },
                                  ),
                                ),
                                const Text('Motos'),
                                IgnorePointer(
                                  ignoring: true,
                                  child: Radio(
                                    value: typeVehicle,
                                    groupValue: typeVehicle,
                                    onChanged: (val) {
                                      setState(() {
                                        typeVehicle = val!;
                                      });
                                    },
                                  ),
                                ),
                                const Text('Automoviles'),
                                IgnorePointer(
                                  ignoring: true,
                                  child: Radio(
                                    value: typeVehicle,
                                    groupValue: typeVehicle,
                                    onChanged: (val) {
                                      setState(() {
                                        typeVehicle = val!;
                                      });
                                    },
                                  ),
                                ),
                                const Text(
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
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(220, 217, 217, 217),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Informacion',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Alinea los elementos a los lados
                              children: [
                                const Text(
                                  'Placa: ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: placaController,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Marca: ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: marcaController,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Alinea los elementos a los lados
                              children: [
                                const Text(
                                  'Color: ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller:
                                        colorController, // Usa tu controlador aquí
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Modelo: ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: modeloController,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(16),
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
                                fontSize: 16.0,
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
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(220, 217, 217, 217),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Fecha Llegada',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 25),
                            TextField(
                              readOnly: true,
                              controller: fechaInicioController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Urbanist',
                              ),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(220, 217, 217, 217),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Fecha Salida',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 25),
                            TextField(
                              readOnly: true,
                              controller: fechaFinController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Urbanist',
                              ),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.only(
                                    left: 80, right: 80, top: 20, bottom: 20)),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red[500]),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Ajusta el radio para redondear las esquinas
                              ),
                            ),
                          ),
                          child: const Text(
                            ' Registrar',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            final User? user = FirebaseAuth.instance.currentUser;
                            DocumentSnapshot parqueoDoc = FirebaseFirestore.instance.collection(Collection.reservas).doc(user!.uid).get() as DocumentSnapshot<Object?>;
                            Map<String, dynamic> userData = parqueoDoc.data() as Map<String, dynamic>;
                            
                            Map<String, dynamic> cliente = {
                              'nombre': userData[UsersCollection.nombre],
                              'apellidos': userData[UsersCollection.apellidos],
                              'telefono': userData[UsersCollection.telefono],
                            };
                            Map<String, dynamic> vehiculo = {
                              'tipo': typeVehicle,
                              'placaVehiculo': placaController.text,
                              'marcaVehiculo': marcaController.text,
                              'colorVehiculo': colorController.text,
                              'modeloVehiculo': modeloController.text,
                            };
                            Map<String, dynamic> parqueo = {
                              'nombre': nombreParqueo,
                              'piso': pisoController.text,
                              'fila': filaController.text,
                              'cuentaCobertura': widget.dataSearch.tieneCobertura
                            };

                            Map<String, dynamic> data = {
                              'cliente': cliente,
                              'vehiculo': vehiculo,
                              'parqueo': parqueo,
                              'estado': typeVehicle,
                              'fechaLlegada': widget.dataSearch.fechaInicio,
                              'fechaSalida': widget.dataSearch.fechaFin,
                              'total': widget.dataSearch.total,
                            };
                            agregarReserva(datos: data);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HomeClient()),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> agregarReserva({required Map<String, dynamic> datos}) async {

    await FirebaseFirestore.instance.collection(Collection.reservas).add(datos);
  }
}

/*




 */