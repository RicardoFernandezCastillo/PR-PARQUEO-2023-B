import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationDetails extends StatefulWidget {
  const ReservationDetails({Key? key}) : super(key: key);

  @override
  _ReservationDetailsState createState() => _ReservationDetailsState();
}

class _ReservationDetailsState extends State<ReservationDetails> {
  TextEditingController nombreParqueo = TextEditingController();
  TextEditingController pisoController = TextEditingController();
  TextEditingController filaController = TextEditingController();
  TextEditingController plazaController = TextEditingController();
  TextEditingController placaController = TextEditingController();
  TextEditingController marcaController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController modeloController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  DateTime? reservationDateIn, reservationDateOut;
  bool radioValue = false;
  List<bool> checkboxValues = [false, false, false];

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
      DocumentSnapshot reservaDocument = await FirebaseFirestore.instance
          .collection('reserva')
          .doc(
              'tHHhTWGuAVdhjuIN5u8k') // Reemplaza 'ID_DEL_DOCUMENTO' por el ID real del documento que deseas recuperar
          .get();

      DocumentSnapshot ticketDocument = await FirebaseFirestore.instance
          .collection('ticket')
          .doc(
              'sFT1XDlqXxsOAfLudVHw') // Reemplaza 'ID_DEL_DOCUMENTO' por el ID real del documento que deseas recuperar
          .get();

      Map<String, dynamic> dataReserve =
          reservaDocument.data() as Map<String, dynamic>;

      Map<String, dynamic> dataTicket =
          ticketDocument.data() as Map<String, dynamic>;

      setState(() {
        nombreParqueo.text = 'Parqueo ${dataReserve['parqueo']['nombre']}';
        pisoController.text = dataReserve['parqueo']['piso'];
        filaController.text = dataReserve['parqueo']['fila'];
        plazaController.text = dataReserve['parqueo']['plaza'];
        if (dataReserve['vehiculo']['tipo'] == "Moto") {
          checkboxValues[0] = true;
        } else if (dataReserve['vehiculo']['tipo'] == "Automóvil") {
          checkboxValues[1] = true;
        } else if (dataReserve['vehiculo']['tipo'] == "Otro") {
          checkboxValues[2] = true;
        }
        estadoController.text = dataReserve['estado'];
        placaController.text = dataReserve['vehiculo']['placa'];
        marcaController.text = dataReserve['vehiculo']['marca'];
        colorController.text = dataReserve['vehiculo']['color'];
        modeloController.text = dataReserve['vehiculo']['modelo'];
        radioValue = dataReserve['parqueo']['cobertura'];
        Timestamp timestampDateOut = dataTicket['dateOut'];
        reservationDateOut = timestampDateOut.toDate();
        Timestamp timestampDateIn = dataTicket['dateArrive'];
        reservationDateIn = timestampDateIn.toDate();
        
      });
    } catch (e) {
      print(e);
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
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(220, 217, 217, 217),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Vehiculos Reservado',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                IgnorePointer(
                                  ignoring:
                                      true, // Esto hace que los Checkbox sean de solo lectura
                                  child: Checkbox(
                                    value: checkboxValues[0],
                                    onChanged: null,
                                    activeColor: Colors
                                        .blueAccent, // Pasar null a onChanged deshabilita la interacción
                                  ),
                                ),
                                const Text('Motos'),
                                IgnorePointer(
                                  ignoring: true,
                                  child: Checkbox(
                                    value: checkboxValues[1],
                                    onChanged: null,
                                  ),
                                ),
                                const Text('Automoviles'),
                                IgnorePointer(
                                  ignoring: true,
                                  child: Checkbox(
                                    value: checkboxValues[2],
                                    onChanged: null,
                                  ),
                                ),
                                const Text('Otros'),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(220, 217, 217, 217),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Estado',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: estadoController,
                              style: const TextStyle(fontSize: 18),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets
                                    .zero, // Elimina el relleno interior del TextField
                                border: InputBorder
                                    .none, // Elimina el borde predeterminado
                                focusedBorder: InputBorder
                                    .none, // Elimina el borde de enfoque
                              ),
                            ),
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
                                    readOnly: true, // Usa tu controlador aquí
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets
                                          .zero, // Elimina el relleno interior del TextField
                                      border: InputBorder
                                          .none, // Elimina el borde predeterminado
                                      focusedBorder: InputBorder
                                          .none, // Elimina el borde de enfoque
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
                                    readOnly: true,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets
                                          .zero, // Elimina el relleno interior del TextField
                                      border: InputBorder
                                          .none, // Elimina el borde predeterminado
                                      focusedBorder: InputBorder
                                          .none, // Elimina el borde de enfoque
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
                                    controller: colorController,
                                    readOnly: true, // Usa tu controlador aquí
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets
                                          .zero, // Elimina el relleno interior del TextField
                                      border: InputBorder
                                          .none, // Elimina el borde predeterminado
                                      focusedBorder: InputBorder
                                          .none, // Elimina el borde de enfoque
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
                                    readOnly: true,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets
                                          .zero, // Elimina el relleno interior del TextField
                                      border: InputBorder
                                          .none, // Elimina el borde predeterminado
                                      focusedBorder: InputBorder
                                          .none, // Elimina el borde de enfoque
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
                            InkWell(
                              child: Row(
                                children: [
                                  const Icon(Icons
                                      .calendar_today), // Ícono de calendario
                                  const SizedBox(
                                      width:
                                          8), // Espacio entre el ícono y el texto
                                  Text(
                                    reservationDateIn != null
                                        ? DateFormat('dd/MM/yyyy HH:mm')
                                            .format(reservationDateIn!)
                                        : 'Selecciona Fecha y Hora',
                                  ),
                                ],
                              ),
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
                            const Text('Fecha Salida',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 25),
                            InkWell(
                              child: Row(
                                children: [
                                  const Icon(Icons
                                      .calendar_today), // Ícono de calendario
                                  const SizedBox(
                                      width:
                                          8), // Espacio entre el ícono y el texto
                                  Text(
                                    reservationDateOut != null
                                        ? DateFormat('dd/MM/yyyy HH:mm')
                                            .format(reservationDateOut!)
                                        : 'Selecciona Fecha y Hora',
                                  ),
                                ],
                              ),
                            )
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
                            ' Regresar',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
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
}
