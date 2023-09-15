import 'package:flutter/material.dart';

class RegistroParqueoScreen extends StatefulWidget {
  @override
  _RegistroParqueoScreenState createState() => _RegistroParqueoScreenState();
}

class _RegistroParqueoScreenState extends State<RegistroParqueoScreen> {
  String? vehiculoSeleccionado = "Autos"; // Inicializado con un valor predeterminado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 131, 255),
        title: Text("Registro de Parqueo"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input de texto para el nombre del parqueo
            Text("1. Nombre del Parqueo"),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Ingrese el nombre del parqueo",
              ),
            ),
            SizedBox(height: 20.0),

            // Input de texto para la dirección del parqueo
            Text("2. Dirección del Parqueo"),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Ingrese la dirección del parqueo",
              ),
            ),
            SizedBox(height: 20.0),

            // Input de texto para la latitud y longitud
            Text("3. Coordenadas"),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Latitud",
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Longitud",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),

            // Switch para "Cuenta con cubierta"
            Text("4. Cuenta con cubierta"),
            Row(
              children: [
                Text("No"),
                Switch(
                  value: vehiculoSeleccionado == "Sí",
                  onChanged: (value) {
                    setState(() {
                      vehiculoSeleccionado = value ? "Sí" : "No";
                    });
                  },
                ),
                Text("Sí"),
              ],
            ),
            SizedBox(height: 20.0),

            // Input de texto grande para la descripción del parqueo
            Text("5. Descripción del Parqueo"),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Ingrese la descripción del parqueo",
              ),
            ),
            SizedBox(height: 20.0),

            // Título "Vehículos permitidos"
            Text("6. Vehículos permitidos"),
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
                Text("Autos"),
                Radio(
                  value: "Motos",
                  groupValue: vehiculoSeleccionado,
                  onChanged: (value) {
                    setState(() {
                      vehiculoSeleccionado = value;
                    });
                  },
                ),
                Text("Motos"),
                Radio(
                  value: "Mixto",
                  groupValue: vehiculoSeleccionado,
                  onChanged: (value) {
                    setState(() {
                      vehiculoSeleccionado = value;
                    });
                  },
                ),
                Text("Mixto"),
              ],
            ),
            SizedBox(height: 20.0),

            // Input de texto para el NIT del propietario
            Text("7. NIT del Propietario"),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Ingrese el NIT del propietario",
              ),
            ),
            SizedBox(height: 20.0),

            // Tarifas de auto y moto
            Text("8. Tarifas"),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Autos: hora/"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Ingrese tarifa por hora",
                        ),
                      ),
                      Text("Bs. - día/"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Ingrese tarifa por día",
                        ),
                      ),
                      Text("Bs."),
                    ],
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Motos: hora/"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Ingrese tarifa por hora",
                        ),
                      ),
                      Text("Bs. - día/"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Ingrese tarifa por día",
                        ),
                      ),
                      Text("Bs."),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),

            // Input de texto para la hora de apertura y cierre
            Text("9. Horario de Apertura y Cierre"),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Hora de Apertura",
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Hora de Cierre",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Agrega aquí la lógica para procesar el registro
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 23, 131, 255), // Color de fondo azul
                onPrimary: Colors.white, // Color del texto en blanco
                padding: EdgeInsets.all(16.0),
              ),
              child: Text("Registrar"),
            ),
          ],
        ),
      ),
    );
  }
}
