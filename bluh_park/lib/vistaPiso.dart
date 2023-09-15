import 'package:flutter/material.dart';

class ParqueoHupermallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 131, 255),
        title: Text("Parqueo Hupermall"),
      ),
      body: ListView(
        children: [
          for (int i = 1; i <= 4; i++)
            FilaParqueo(
              nombrePiso: "Piso -$i",
              cantidadFilas: 15,
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/agregar_piso');
        },
        backgroundColor: Color.fromARGB(255, 23, 131, 255),
        child: Icon(Icons.add),
      ),
    );
  }
}

class FilaParqueo extends StatelessWidget {
  final String nombrePiso;
  final int cantidadFilas;

  FilaParqueo({
    required this.nombrePiso,
    required this.cantidadFilas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            nombrePiso,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(width: 10.0),
          Text("Cantidad de filas: $cantidadFilas"),
          SizedBox(width: 10.0),
          ElevatedButton(
            onPressed: () {
              // Acción cuando se presiona el botón "Editar"
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 216, 216, 216)),
            ),
            child: Text("Editar"),
          ),
        ],
      ),
    );
  }
}
