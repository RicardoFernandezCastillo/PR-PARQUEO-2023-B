import 'package:flutter/material.dart';

class HomeClient extends StatelessWidget {
  const HomeClient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 1200,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              child: Container(
                color: const Color(0xff2e61e6),
                height: 250,
                child: Center(
                    child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Bienvenido User',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      'assets/logo.png',
                      width: 150,
                      height: 100,
                    ),
                    const Text(
                      'BLUH PARK',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                )),
              ),
            ),
            Positioned(
              top: 190,
              left: 0,
              right: 0,
              child: Card(
                elevation: 4,
                borderOnForeground: true,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  height: 135,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.file_open_rounded),
                            onPressed: () {
                              // Agrega la lógica para el botón 'Mis parqueos' aquí
                            },
                            iconSize: 50,
                            color: const Color(0xff2e61e6),
                          ),
                          const Text(
                            'Nueva Reserva',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      Column(children: [
                        IconButton(
                          icon: const Icon(Icons.assignment_rounded),
                          onPressed: () {
                            // Agrega la lógica para el botón 'Reservas solicitadas' aquí
                          },
                          iconSize: 50,
                          color: const Color(0xff2e61e6),
                        ),
                        const Text(
                          'Reservas Activas',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 340,
              left: 0,
              right: 0,
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  height: 350,
                  padding: const EdgeInsets.all(16),
                  child: const Column(
                    children: [
                      ListTile(
                        title: Text("Ubicación Mis Parqueos"),
                      ),
                      SizedBox(
                        height: 200,
                        child: Text(
                          "Mapa",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}