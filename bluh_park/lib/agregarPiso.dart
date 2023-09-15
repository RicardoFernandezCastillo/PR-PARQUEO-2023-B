//import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';

class AgregarPisoScreen extends StatefulWidget {
  @override
  _AgregarPisoScreenState createState() => _AgregarPisoScreenState();
}

class _AgregarPisoScreenState extends State<AgregarPisoScreen> {
  int cantidadFilas = 5;
  List<String> nombresFilas = List.generate(5, (index) => "");

  void agregarFila() {
    setState(() {
      cantidadFilas++;
      nombresFilas.add("");
    });
  }

  void eliminarFila() {
    if (cantidadFilas > 0) {
      setState(() {
        cantidadFilas--;
        nombresFilas.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 131, 255),
        title: Text("Añadir Piso"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Nombre del piso
            TextField(
              decoration: InputDecoration(labelText: "Nombre del piso"),
            ),
            SizedBox(height: 20.0),
            // Botones "más" y "menos"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: agregarFila,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 23, 131, 255)),
                  ),
                  child: Text("+", style: TextStyle(fontSize: 35.0, fontWeight:FontWeight.bold)),
                ),
                ElevatedButton(
                  onPressed: eliminarFila,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 23, 131, 255)),
                  ),
                  child: Text("-", style: TextStyle(fontSize: 35.0, fontWeight:FontWeight.bold)),
                  
                ),
              ],
            ),
            SizedBox(height: 20.0),
            // Campos de entrada de texto para nombres de filas
            Column(
              children: List.generate(
                cantidadFilas,
                (index) => TextField(
                  decoration: InputDecoration(
                    labelText: "Nombre de la fila ${index + 1}",
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
