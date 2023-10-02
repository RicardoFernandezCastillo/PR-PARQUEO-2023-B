import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

 

class Reserva {
  // final String idReserva;

  // final String idParqueo;

  // final String idPiso;

  // final String idFila;

  // final String vehiculoPermitido;

  // final String placaVehiculo;

  // final String marcaVehiculo;
  
  // final String colorVehiculo;

  // final String modeloVehiculo;

  // final bool cuentaCobertura;

  // final String fechaLlegada;

  // final String horaLlegada;

  // final String fechaSalida;

  // final String horaSalida;

  // final String precioTotal;


  final Map<String, dynamic> cliente;
  final Map<String, dynamic> parqueo;
  final Map<String, dynamic> ticket;
  final Map<String, dynamic> vehiculo;


  // Reserva(this.idReserva, this.idParqueo, this.idPiso, this.idFila, this.vehiculoPermitido, 
  // this.placaVehiculo, this.marcaVehiculo, this.colorVehiculo, this.modeloVehiculo,
  // this.cuentaCobertura, this.fechaLlegada, this.horaLlegada, this.fechaSalida, this.horaSalida,
  // this.precioTotal);

  Reserva(this.cliente, this.parqueo, this.ticket, this.vehiculo);
}
 



 

class CreateReservaScreen extends StatelessWidget {
  static const routeName = '/vista-reserva';

  //final String idParqueo;

  //CreateReservaScreen({required this.idParqueo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Formulario de Reserva'),
          backgroundColor: const Color.fromARGB(255, 5, 126, 225),
        ),
        //body: ReservaListScreen(idParqueo: idParqueo,),
        body: ReservaListScreen(),
      ),
    );
  }
}


class ReservaListScreen extends StatefulWidget {
  //final String idParqueo;
  
  //ReservaListScreen({required this.idParqueo});

  @override
  _ReservaListScreenState createState() => _ReservaListScreenState();
}

class _ReservaListScreenState extends State<ReservaListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Reservas'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ... otros widgets ...

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgregarReservaScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: const Text('Agregar Reserva'),
            ),
          ],
        ),
      ),
    );
  }
}



class AgregarReservaScreen extends StatefulWidget {
  @override
  _AgregarReservaScreenState createState() => _AgregarReservaScreenState();
}

class _AgregarReservaScreenState extends State<AgregarReservaScreen> {

  String vehiculoSeleccionado = 'Autos';
  String coberturaSeleccionada = 'SI';
  TextEditingController idParqueoController = TextEditingController();
  TextEditingController idPisoController = TextEditingController();
  TextEditingController idFilaController = TextEditingController();
  TextEditingController vehiculoPermitidoController = TextEditingController();
  TextEditingController placaVehiculoController = TextEditingController();
  TextEditingController marcaVehiculoController = TextEditingController();
  TextEditingController colorVehiculoController = TextEditingController();
  TextEditingController modeloVehiculoController = TextEditingController();
  TextEditingController cuentaCoberturaController = TextEditingController();
  TextEditingController fechaLlegadaController = TextEditingController();
  TextEditingController horaLlegadaController = TextEditingController();
  TextEditingController fechaSalidaController = TextEditingController();
  TextEditingController horaSalidaController = TextEditingController();
  TextEditingController precioTotalController = TextEditingController();


  Map<String, dynamic>? cliente;
  Map<String, dynamic>? parqueo;
  Map<String, dynamic>? ticket;
  Map<String, dynamic>? vehiculo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nueva Reserva'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("ID del Parqueo"),
            TextFormField(
              controller: idParqueoController,
              decoration: InputDecoration(
                hintText: "Ingrese el ID del Parqueo",
              ),
            ),
            SizedBox(height: 20.0),

            Text("ID del Piso"),
            TextFormField(
              controller: idPisoController,
              decoration: InputDecoration(
                hintText: "Ingrese el ID del Piso",
              ),
            ),
            SizedBox(height: 20.0),

            Text("ID de la Fila"),
            TextFormField(
              controller: idFilaController,
              decoration: InputDecoration(
                hintText: "Ingrese el ID de la Fila",
              ),
            ),
            SizedBox(height: 20.0),

            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tipo de Vehículo:"),
                  Row(
                    children: [
                      Radio(
                        value: 'Autos',
                        groupValue: vehiculoSeleccionado,
                        onChanged: (value) {
                          setState(() {
                            vehiculoSeleccionado = value as String;
                          });
                        },
                      ),
                      Text('Autos'),
                      Radio(
                        value: 'Motos',
                        groupValue: vehiculoSeleccionado,
                        onChanged: (value) {
                          setState(() {
                            vehiculoSeleccionado = value as String;
                          });
                        },
                      ),
                      Text('Motos'),
                      Radio(
                        value: 'Mixto',
                        groupValue: vehiculoSeleccionado,
                        onChanged: (value) {
                          setState(() {
                            vehiculoSeleccionado = value as String;
                          });
                        },
                      ),
                      Text('Mixto'),
                    ],
                  ),
                ],
              ),
            ),

            // Grupo de entradas de texto para Placa, Marca, Color y Modelo
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Placa:"),
                  TextFormField(
                    controller: placaVehiculoController,
                    decoration: InputDecoration(
                      hintText: "Ingrese la placa",
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text("Marca:"),
                  TextFormField(
                    controller: marcaVehiculoController,
                    decoration: InputDecoration(
                      hintText: "Ingrese la marca",
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text("Color:"),
                  TextFormField(
                    controller: colorVehiculoController,
                    decoration: InputDecoration(
                      hintText: "Ingrese el color",
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text("Modelo:"),
                  TextFormField(
                    controller: modeloVehiculoController,
                    decoration: InputDecoration(
                      hintText: "Ingrese el modelo",
                    ),
                  ),
                ],
              ),
            ),

            // Grupo de radio buttons para Cobertura
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cuenta con cobertura:"),
                  Row(
                    children: [
                      Radio(
                        value: 'SI',
                        groupValue: coberturaSeleccionada,
                        onChanged: (value) {
                          setState(() {
                            coberturaSeleccionada = value as String;
                          });
                        },
                      ),
                      
                      Text('SI'),
                      Radio(
                        value: 'NO',
                        groupValue: coberturaSeleccionada,
                        onChanged: (value) {
                          setState(() {
                            coberturaSeleccionada = value as String;
                          });
                        },
                      ),
                      Text('NO'),
                    ],
                  ),
                ],
              ),
            ),

            // Grupo de entradas de texto para Fecha y Hora de Llegada y Salida
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Fecha de Llegada:"),
                  TextFormField(
                    controller: fechaLlegadaController,
                    decoration: InputDecoration(
                      hintText: "Ingrese la fecha de llegada",
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text("Hora de Llegada:"),
                  TextFormField(
                    controller: horaLlegadaController,
                    decoration: InputDecoration(
                      hintText: "Ingrese la hora de llegada",
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text("Fecha de Salida:"),
                  TextFormField(
                    controller: fechaSalidaController,
                    decoration: InputDecoration(
                      hintText: "Ingrese la fecha de salida",
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text("Hora de Salida:"),
                  TextFormField(
                    controller: horaSalidaController,
                    decoration: InputDecoration(
                      hintText: "Ingrese la hora de salida",
                    ),
                  ),
                ],
              ),
            ),

            // Texto de Precio Total
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text("Precio total: 90 Bs."),
              ),
            ),

            // Agrega más campos para los datos de la reserva según tu clase Reserva

            ElevatedButton(
              onPressed: () async {
                // Aquí puedes implementar la lógica para agregar una nueva reserva
                // utilizando los datos ingresados en los controladores.
                Map<String, dynamic> data = {
                  'idParqueo': idParqueoController.text,
                  'idPiso': idPisoController.text,
                  'idFila': idFilaController.text,
                  'vehiculoPermitido': vehiculoPermitidoController.text,
                  'placaVehiculo': placaVehiculoController.text,
                  'marcaVehiculo': marcaVehiculoController.text,
                  'colorVehiculo': colorVehiculoController.text,
                  'modeloVehiculo': modeloVehiculoController.text,
                  'cuentaCobertura': coberturaSeleccionada,
                  'fechaLlegada': fechaLlegadaController.text,
                  'horaLlegada': horaLlegadaController.text,
                  'fechaSalida': fechaSalidaController.text,
                  'horaSalida': horaSalidaController.text,
                  'precioTotal': precioTotalController.text,
                };

                await agregarReserva(data);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: const Text('Reservar'),
            ),
          ],
        ),
      ),
    );
  }
}




Future<void> agregarReserva(Map<String, dynamic> datos) async {

  // Obtén una referencia a la colección principal, en este caso, 'parqueos'

  CollectionReference reserva =

      FirebaseFirestore.instance.collection('reserva');

  // Obtén una referencia al documento del parqueo
  

  
  await reserva.doc().set(datos);

}

 

