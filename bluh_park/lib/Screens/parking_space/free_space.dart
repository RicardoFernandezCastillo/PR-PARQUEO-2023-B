import 'package:flutter/material.dart';

class Plaza {
  final String nombre;
  final bool tieneCobertura;

  Plaza(this.nombre, this.tieneCobertura);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PlazaListScreen(),
    );
  }
}

class PlazaListScreen extends StatefulWidget {
  const PlazaListScreen({super.key});

  @override
  _PlazaListScreenState createState() => _PlazaListScreenState();
}

class _PlazaListScreenState extends State<PlazaListScreen> {
  List<Plaza> plazas = [
    Plaza('Plaza 1', true),
    Plaza('Plaza 2', false),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Plazas'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: plazas.length,
        itemBuilder: (context, index) {
          final plaza = plazas[index];
          return ListTile(
            title: Text(plaza.nombre),
            subtitle: Text(plaza.tieneCobertura ? 'Con Cobertura' : 'Sin Cobertura'),
            trailing: IconButton(
              icon: const Icon(Icons.edit), // Puedes usar cualquier icono que desees.
              onPressed: () {
                // Implementa aquí la lógica para editar la plaza.
                //print('Editar plaza: ${plaza.nombre}');
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla de agregar una nueva plaza.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgregarPlazaScreen()),
          ).then((plaza) {
            if (plaza != null) {
              // Si se agrega una nueva plaza, actualiza la lista.
              setState(() {
                plazas.add(plaza);
              });
            }
          });
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AgregarPlazaScreen extends StatelessWidget {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController coberturaController = TextEditingController();

  AgregarPlazaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nueva Plaza'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre de la Plaza'),
            ),
            TextField(
              controller: coberturaController,
              decoration: const InputDecoration(labelText: 'Tiene Cobertura (true/false)'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final nombre = nombreController.text;
                final tieneCobertura = coberturaController.text.toLowerCase() == 'true';

                // Crea una nueva Plaza y devuelve los datos a la pantalla anterior.
                Navigator.pop(
                  context,
                  Plaza(nombre, tieneCobertura),
                );
              },
              child: const Text('Agregar Plaza'),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
