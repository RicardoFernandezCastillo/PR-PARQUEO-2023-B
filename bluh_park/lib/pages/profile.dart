import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc('Gurl2Bh0zlPTZLSF1wwhChmVA3W2')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final data = snapshot.data!.data() as Map<String, dynamic>;
              final name = data['nombre'];
              final lasname = data['apellidos'];
              final email = data['correo'];

              return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Perfil',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  centerTitle: true,
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/profile.png'),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          email + ' ' + lasname,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Correo electrónico',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 60),
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('Información personal'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Navegar a la página de información personal
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 60),
                      child: ListTile(
                        leading: const Icon(Icons.lock),
                        title: const Text('Cambiar contraseña'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Navegar a la página de cambio de contraseña
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 60),
                      child: ListTile(
                        leading: const Icon(Icons.exit_to_app),
                        title: const Text('Cerrar sesión'),
                        onTap: () {
                          // Cerrar sesión
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: Text('No se encontraron datos de usuario'),
                ),
              );
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
