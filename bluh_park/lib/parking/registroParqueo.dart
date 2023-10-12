// ignore: file_names
import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_create_account/utilities/progressbar.dart';
import 'package:flutter_create_account/utilities/toast.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class RegistroParqueoScreen extends StatefulWidget {
  static const routeName = '/register-parking-srceen';

  const RegistroParqueoScreen({super.key});
  @override
  _RegistroParqueoScreenState createState() => _RegistroParqueoScreenState();
}

class _RegistroParqueoScreenState extends State<RegistroParqueoScreen> {
  String? vehiculoSeleccionado = "Autos";
  List<DateTime?> selectedDate = [null, null];
  List<TimeOfDay?> selectedTime = [null, null];

  TextEditingController nombreController = TextEditingController();

  TextEditingController direccionController = TextEditingController();

  TextEditingController latitudController = TextEditingController();

  TextEditingController longitudController = TextEditingController();

  bool? tieneCoberturaController;

  TextEditingController descripcionController = TextEditingController();

  Map<String, bool>? vehiculosPermitidosController;

  TextEditingController nitController = TextEditingController();

  Map<String, double>? tarifaMotoController;

  Map<String, double>? tarifaAutomovilController;

  Map<String, double>? tarifaOtroController;

  TextEditingController motoHoraController = TextEditingController();
  TextEditingController motoDiaController = TextEditingController();
  TextEditingController automovilHoraController = TextEditingController();
  TextEditingController automovilDiaController = TextEditingController();
  TextEditingController otroHoraController = TextEditingController();
  TextEditingController otroDiaController = TextEditingController();

  File? _image;

  Future<void> _getImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
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
        initialTime: TimeOfDay.fromDateTime(
          selectedDate[0] ?? DateTime.now(),
        ),
      );
      if (pickedTime != null) {
        if ((pickedTime.hour > 6 && pickedTime.hour < 22)) {
          if ((pickedTime.minute == 0 && pickedTime.hour == 22 - 1) ||
              (pickedTime.hour != 22 - 1)) {
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

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 65, 100, 140),
        title: const Text(
          "Registro de Parqueo",
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w800,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          iconSize: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Card(
                color: Color.fromARGB(255, 255, 255, 255),
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "1. Nombre del Parqueo",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: nombreController,
                        decoration: InputDecoration(
                          hintText: 'Ingrese el nombre del Parqueo',
                          hintStyle: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 18,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFE8ECF4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        '2. Foto del parqueo',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black87,
                            width: 1.0,
                          ),
                          color: const Color(0xFFE8ECF4),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            if (_image != null)
                              Center(
                                // Centra la imagen
                                child: SizedBox(
                                  width: 250,
                                  height: 200,
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            if (_image != null)
                              IconButton(
                                onPressed: () => {
                                  setState(() {
                                    _image = null;
                                  })
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red[600],
                                ),
                              ),
                            if (_image == null)
                              InkWell(
                                onTap: () => _getImageFromGallery(),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.photo_library,
                                    ),
                                    SizedBox(width: 8),
                                    Text('Selecciona imagen'),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "3. Dirección del Parqueo",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: direccionController,
                        decoration: InputDecoration(
                          hintText: 'Ingrese la direccion del Parqueo',
                          hintStyle: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 18,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFE8ECF4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "4. Coordenadas",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: latitudController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ), // Ajusta estos valores según tus necesidades
                                hintText: 'Latitud',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 18,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFE8ECF4),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: TextField(
                              controller: longitudController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ), // Ajusta estos valores según tus necesidades
                                hintText: 'Longitud',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 18,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFE8ECF4),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "5. Cuenta con cubierta",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          const Text("No"),
                          Switch(
                            value: vehiculoSeleccionado == "Sí",
                            onChanged: (value) {
                              setState(() {
                                vehiculoSeleccionado = value ? "Sí" : "No";
                              });
                            },
                          ),
                          const Text("Sí"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "6. Descripción del Parqueo",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        maxLines: 4,
                        controller: descripcionController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0,
                          ), // Ajusta estos valores según tus necesidades
                          hintText: 'Ingrese la descripcion del parqueo',
                          hintStyle: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 18,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFE8ECF4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "7. Vehículos permitidos",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Radio(
                            value: "Autos",
                            groupValue: vehiculoSeleccionado,
                            onChanged: (value) {
                              setState(() {
                                vehiculoSeleccionado = value;
                              });
                            },
                          ),
                          const Text("Autos"),
                          Radio(
                            value: "Motos",
                            groupValue: vehiculoSeleccionado,
                            onChanged: (value) {
                              setState(() {
                                vehiculoSeleccionado = value;
                              });
                            },
                          ),
                          const Text("Motos"),
                          Radio(
                            value: "Mixto",
                            groupValue: vehiculoSeleccionado,
                            onChanged: (value) {
                              setState(() {
                                vehiculoSeleccionado = value;
                              });
                            },
                          ),
                          const Text("Mixto"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "8. NIT del Propietario",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: nitController,
                        decoration: InputDecoration(
                          hintText: 'Ingrese el NIT del propietario',
                          hintStyle: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 18,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFE8ECF4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "9. Tarifas",
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
                              controller: automovilHoraController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ), // Ajusta estos valores según tus necesidades
                                hintText: 'tarifa por hora',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 18,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFE8ECF4),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: automovilDiaController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ), // Ajusta estos valores según tus necesidades
                                hintText: 'tarifa por dia',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 18,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFE8ECF4),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
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
                              controller: motoHoraController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ), // Ajusta estos valores según tus necesidades
                                hintText: 'tarifa por hora',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 18,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFE8ECF4),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: motoDiaController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ), // Ajusta estos valores según tus necesidades
                                hintText: 'tarifa por dia',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 18,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFE8ECF4),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
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
                              controller: otroHoraController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ), // Ajusta estos valores según tus necesidades
                                hintText: 'tarifa por hora',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 18,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFE8ECF4),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: otroDiaController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ), // Ajusta estos valores según tus necesidades
                                hintText: 'tarifa por dia',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 18,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFE8ECF4),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        '9. Horario de Apertura ',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 14,
                          left: 14,
                          bottom: 14,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black87,
                            width: 1.0,
                          ),
                          color: const Color(0xFFE8ECF4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              onTap: () => _selectDateAndTimeInitial(context),
                              child: Row(
                                children: <Widget>[
                                  const Icon(Icons.calendar_today),
                                  const SizedBox(
                                      width:
                                          8), // Espacio entre el ícono y el texto
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
                      const SizedBox(height: 20),
                      const Text(
                        '10. Horario de Cierre ',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 14,
                          left: 14,
                          bottom: 14,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black87,
                            width: 1.0,
                          ),
                          color: const Color(0xFFE8ECF4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
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
                                  const Icon(Icons
                                      .calendar_today), // Ícono de calendario
                                  const SizedBox(
                                      width:
                                          8), // Espacio entre el ícono y el texto
                                  Text(
                                    selectedDate[1] != null
                                        ? DateFormat('dd/MM/yyyy HH:mm')
                                            .format(selectedDate[1]!)
                                        : 'Selecciona Fecha y Hora',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStatePropertyAll(
                              EdgeInsets.only(
                                left: width / 8,
                                right: width / 8,
                                top: 20,
                                bottom: 20,
                              ),
                            ),
                            backgroundColor: MaterialStatePropertyAll<Color?>(
                              Colors.red[500],
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ), // Ajusta el radio para redondear las esquinas
                              ),
                            ),
                          ),
                          onPressed: () async {
                            await ProgressDialog.show(
                              context,
                              'Registrando Parqueo',
                            );
                            String? urlPath = await addImageToFireStorage();
                            if (urlPath != null || urlPath != '') {
                              GeoPoint ubicacion = GeoPoint(
                                double.parse(latitudController.text),
                                double.parse(longitudController.text),
                              );
                              Map<String, bool> vhp = {
                                'Autos': true,
                                'Motos': true,
                                'Otros': false
                              };
                              Map<String, double> tarifaMoto = {
                                'Dia': double.parse(motoDiaController.text),
                                'Hora': double.parse(motoHoraController.text)
                              };
                              Map<String, double> tarifaAutomovil = {
                                'Dia':
                                    double.parse(automovilDiaController.text),
                                'Hora':
                                    double.parse(automovilHoraController.text)
                              };
                              Map<String, double> tarifaOtro = {
                                'Dia': double.parse(otroDiaController.text),
                                'Hora': double.parse(otroHoraController.text)
                              };

                              Map<String, dynamic> data = {
                                'nombre': nombreController.text,
                                'direccion': direccionController.text,
                                'ubicacion': ubicacion,
                                'tieneCobertura': true,
                                'descripcion': descripcionController.text,
                                'vehiculosPermitidos': vhp,
                                'nit': nitController.text,
                                'tarifaMoto': tarifaMoto,
                                'tarifaAutomovil': tarifaAutomovil,
                                'tarifaOtro': tarifaOtro,
                                'horaApertura': selectedDate[0],
                                'horaCierre': selectedDate[1],
                                'url': urlPath
                              };
                              await agregarParqueo(datos: data);

                              await ProgressDialog.hide(context);
                            }
                          },
                          child: const Text(
                            'Registrar',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
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

  Future<void> agregarParqueo({required Map<String, dynamic> datos}) async {
    // Obtén una referencia a la colección principal, en este caso, 'parqueos'
    var parqueos = FirebaseFirestore.instance.collection('parqueo');
    try {
      String? imageUrl = await addImageToFireStorage();
      if (imageUrl!.isNotEmpty) {
        // Extrae el nombre de archivo de la URL de descarga
        String fileName = imageUrl.split('/').last;

        // Establece el nombre de archivo en los datos
        datos['url'] = fileName;

        await parqueos.add(datos);
        Toast.show(context, 'Parqueo Registrado Correctamente');
      } else {
        // Trata el caso en el que no se pudo obtener la URL de la imagen
      }
    } catch (e) {
      // Maneja cualquier excepción que pueda ocurrir
      Toast.show(context, 'Error: $e');
    }
  }

  Future<String?> addImageToFireStorage() async {
    try {
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('parqueos/${_image!.path}');

      UploadTask task = storageReference.putFile(_image!);
      TaskSnapshot taskSnapshot = await task.whenComplete(() => {});

      if (taskSnapshot.state == TaskState.success) {
        String imageUrl = await storageReference.getDownloadURL();
        return imageUrl;
      } else {
        return '';
      }
    } catch (e) {
      Toast.show(context, e.toString());
    }
    return '';
  }
}
