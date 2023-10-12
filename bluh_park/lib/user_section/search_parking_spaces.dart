import 'package:flutter/material.dart';
import 'package:flutter_create_account/models/inkwell/inkwell_data.dart';
import 'package:flutter_create_account/utilities/inkwell_personalized.dart';
import 'package:flutter_create_account/utilities/toast.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class ParkingSpaces extends StatefulWidget {
  const ParkingSpaces({
    super.key,
    Key? keySon,
  });

  @override
  State<ParkingSpaces> createState() => _ParkingSpacesState();
}

class _ParkingSpacesState extends State<ParkingSpaces> {
  List<bool> isChecked = [false, false, false];
  bool radioValue = false;
  DateTime? selectedDateArrive;

  List<DateTime?> selectedDate = [null, null];
  List<TimeOfDay?> selectedTime = [null, null];

  Future<void> _selectDateAndTimeInitial(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate[0] ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 20)));
    if (pickedDate != null) {
      // ignore: use_build_context_synchronously
      final TimeOfDay? pickedTime = await showTimePicker(
          helpText: 'Seleccione la hora',
          context: context,
          initialTime:
              TimeOfDay.fromDateTime(selectedDate[0] ?? DateTime.now()));
      if (pickedTime != null) {
        if ((pickedTime.hour > 6 && pickedTime.hour < 22)) {
          if ((pickedTime.minute == 0 && pickedTime.hour == 22 - 1) || (pickedTime.hour != 22 - 1)) {
            setState(() {
              selectedDate[0] = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
              selectedTime[0] = pickedTime;
            });
          }
        } else {
          Toast.show(context, 'Horario no disponible');
        }
      }
    }
  }

  Future<void> _selectDateAndTimeFinal(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      helpText: 'Seleccione una fecha',
      context: context,
      initialDate:
          selectedDate[0] ?? DateTime.now().add(const Duration(hours: 1)),
      firstDate:
          selectedDate[0] ?? DateTime.now().add(const Duration(hours: 1)),
      lastDate: selectedDate[0]?.add(const Duration(days: 20)) ??
          DateTime.now().add(const Duration(days: 20)),
    );
    if (pickedDate != null) {
      // ignore: use_build_context_synchronously
      final TimeOfDay? pickedTime = await showTimePicker(
          helpText: 'Seleccione la hora',
          context: context,
          initialTime:
              TimeOfDay.fromDateTime(selectedDate[0] ?? DateTime.now()));
      if (pickedTime != null) {
        if (pickedTime.hour > 6 && pickedTime.hour < 22) {
          setState(() {
            selectedDate[1] = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
            selectedTime[1] = pickedTime;
          });
        } else {
          Toast.show(context, 'Horario no disponible');
        }
      }
    }
  }

  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        titleTextStyle: const TextStyle(fontSize: 25, color: Colors.white),
        title: const Text(
          'Reserva de Parking',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          iconSize: 30,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        'assets/img_parking_reserve.jpg',
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 16,
                        right: 16,
                        child: Card(
                          elevation: 4.0,
                          color: const Color.fromARGB(158, 245, 245, 245),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: const EdgeInsets.all(16.0),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Estacionamiento',
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(
                                      '4.0',
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Av Peru-Colon',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 0, 255),
                                          ),
                                        ),
                                        Text(
                                          "\$ 20/Hora",
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 0, 255),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
                height: 50.0), // Espacio entre el Card y el nuevo texto
            const Column(
              children: [
                Text(
                  'Vehiculo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: InkwellPerzonalized(
                    inkwellData: InkwellData(
                        isChecked: isChecked[0],
                        message: 'Motos',
                        priceString: '\$10'),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: InkwellPerzonalized(
                    inkwellData: InkwellData(
                        isChecked: isChecked[1],
                        message: 'Auto',
                        priceString: '\$12'),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: InkwellPerzonalized(
                    inkwellData: InkwellData(
                        isChecked: isChecked[2],
                        message: 'Otro',
                        priceString: '\$14'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(top: 14, left: 14),
              decoration: BoxDecoration(
                color: Colors.grey[300], // Color gris
                borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
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
                  Row(
                    children: [
                      Row(
                        children: <Widget>[
                          Radio<bool>(
                            value: true,
                            groupValue: radioValue,
                            onChanged: (bool? value) {
                              setState(() {
                                radioValue = value ?? false;
                              });
                            },
                          ),
                          const Text('Sí'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio<bool>(
                            value: false,
                            groupValue: radioValue,
                            onChanged: (bool? value) {
                              setState(() {
                                radioValue = value ?? false;
                              });
                            },
                          ),
                          const Text('No'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fecha Llegada',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(top: 14, left: 14, bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.lightBlue, // Color del borde
                      width: 2.0, // Ancho del borde
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => _selectDateAndTimeInitial(context),
                        child: Row(
                          children: [
                            const Icon(
                                Icons.calendar_today), // Ícono de calendario
                            const SizedBox(
                                width: 8), // Espacio entre el ícono y el texto
                            Text(
                              selectedDate[0] != null
                                  ? DateFormat('dd/MM/yyyy HH:mm')
                                      .format(selectedDate[0]!)
                                  : 'Selecciona Fecha y Hora',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fecha Salida',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(top: 14, left: 14, bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.lightBlue, // Color del borde
                      width: 2.0, // Ancho del borde
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => {
                          if (selectedDate[0] != null)
                            {_selectDateAndTimeFinal(context)}
                          else
                            {
                              Toast.show(context,
                                  'Primero seleccione la fecha inicial')
                            }
                        },
                        child: Row(
                          children: [
                            const Icon(
                                Icons.calendar_today), // Ícono de calendario
                            const SizedBox(
                                width: 8), // Espacio entre el ícono y el texto
                            Text(
                              selectedDate[1] != null
                                  ? DateFormat('dd/MM/yyyy HH:mm')
                                      .format(selectedDate[1]!)
                                  : 'Selecciona Fecha y Hora',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[500],
                ),
                child: const Text(
                  'Precio',
                  maxLines: 1,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(EdgeInsets.only(
                      left: 80, right: 80, top: 20, bottom: 20)),
                  backgroundColor: MaterialStatePropertyAll(Colors.red[500]),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Ajusta el radio para redondear las esquinas
                    ),
                  ),
                ),
                child: const Text(
                  ' Buscar',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  searchParking(selectedDate[0] ?? DateTime.now());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void searchParking(DateTime selectedDate) {
    var selected = selectedDate;
  }
}
