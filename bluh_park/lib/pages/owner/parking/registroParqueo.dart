import 'package:flutter/material.dart';

class RegistroParqueoScreen extends StatefulWidget {
    static const routeName = '/register-parking-srceen';

  const RegistroParqueoScreen({super.key});
  @override
  _RegistroParqueoScreenState createState() => _RegistroParqueoScreenState();
}

class _RegistroParqueoScreenState extends State<RegistroParqueoScreen> {
  String? vehiculoSeleccionado = "Autos"; // Inicializado con un valor predeterminado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 131, 255),
        title: const Text("Registro de Parqueo"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input de texto para el nombre del parqueo
            const Text("1. Nombre del Parqueo"),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Ingrese el nombre del parqueo",
              ),
            ),
            const SizedBox(height: 20.0),

            // Input de texto para la dirección del parqueo
            const Text("2. Dirección del Parqueo"),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Ingrese la dirección del parqueo",
              ),
            ),
            const SizedBox(height: 20.0),

            // Input de texto para la latitud y longitud
            const Text("3. Coordenadas"),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Latitud",
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Longitud",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // Switch para "Cuenta con cubierta"
            const Text("4. Cuenta con cubierta"),
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
            const SizedBox(height: 20.0),

            // Input de texto grande para la descripción del parqueo
            const Text("5. Descripción del Parqueo"),
            TextFormField(
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Ingrese la descripción del parqueo",
              ),
            ),
            const SizedBox(height: 20.0),

            // Título "Vehículos permitidos"
            const Text("6. Vehículos permitidos"),
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
            const SizedBox(height: 20.0),

            // Input de texto para el NIT del propietario
            const Text("7. NIT del Propietario"),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Ingrese el NIT del propietario",
              ),
            ),
            const SizedBox(height: 20.0),

            // Tarifas de auto y moto
            const Text("8. Tarifas"),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text("Autos: hora/"),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Ingrese tarifa por hora",
                        ),
                      ),
                      const Text("Bs. - día/"),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Ingrese tarifa por día",
                        ),
                      ),
                      const Text("Bs."),
                    ],
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text("Motos: hora/"),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Ingrese tarifa por hora",
                        ),
                      ),
                      const Text("Bs. - día/"),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Ingrese tarifa por día",
                        ),
                      ),
                      const Text("Bs."),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // Input de texto para la hora de apertura y cierre
            const Text("9. Horario de Apertura y Cierre"),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Hora de Apertura",
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Hora de Cierre",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Agrega aquí la lógica para procesar el registro
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 23, 131, 255), // Color de fondo azul
                onPrimary: Colors.white, // Color del texto en blanco
                padding: const EdgeInsets.all(16.0),
              ),
              child: const Text("Registrar"),
            ),
          ],
        ),
      ),
    );
  }
}
