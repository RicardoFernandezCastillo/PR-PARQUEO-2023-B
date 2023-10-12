import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, UserCredential;
import 'package:flutter/material.dart';
import 'models/user.dart';
import 'utilities/progressbar.dart' show ProgressDialog;
import 'utilities/toast.dart' show Toast;

class TypeUser extends StatelessWidget {
  final UserData userData;

  const TypeUser({Key? key, required this.userData,}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          'Tipo de Cuenta',
          style: TextStyle(
            fontSize: 35,
            fontFamily: 'Urbanist',
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          iconSize: 30,
          onPressed: () {
            // Aquí puedes agregar la lógica para manejar la acción del botón
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 150), // Espacio de 20 puntos en la parte superior
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Acción cuando se presiona el botón
                    try {
                      ProgressDialog.show(context, 'Registrando usuario...');
                      userData.typeUser =
                          'Cliente'; // Muestra el diálogo de progreso
                      await registerUser(userData, context);

                      // ignore: use_build_context_synchronously
                      ProgressDialog.hide(context);
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      Toast.show(context, e.toString());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.all(16), // Ajusta el tamaño del botón
                    backgroundColor: Colors.blue, // Color de fondo del botón
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15.0), // Borde redondeado
                    ),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'Cliente',
                        style: TextStyle(
                          fontSize: 45,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Usuario común - Realiza    ',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Urbanist',
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'reserva de parqueos',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Urbanist',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 100,
              ), // Espacio de 20 puntos en la parte superior
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Acción cuando se presiona el botón
                    try {
                      ProgressDialog.show(context, 'Registrando usuario...');
                      userData.typeUser =
                          'Dueño'; // Muestra el diálogo de progreso
                      await registerUser(userData, context);

                      // ignore: use_build_context_synchronously
                      ProgressDialog.hide(context);
                      // ignore: use_build_context_synchronously
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      ProgressDialog.hide(
                          context); // Asegúrate de ocultar el diálogo de progreso en caso de error
                      // ignore: use_build_context_synchronously
                      Toast.show(context, e.toString());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.all(16), // Ajusta el tamaño del botón
                    backgroundColor: Colors.blue, // Color de fondo del botón
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15.0), // Borde redondeado
                    ),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'Dueño',
                        style: TextStyle(
                          fontSize: 45,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Usuario Gestor - Realiza la',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Urbanist',
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'gestion de su parqueo',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Urbanist',
                          color: Colors.white,
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

Future<void> registerUser(UserData userData, BuildContext context) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: userData
          .correoElectronico, // Reemplaza con el valor del correo electrónico del usuario
      password: userData.contrasena, // Reemplaza con la contraseña del usuario
    );

    // Verifica si la creación de usuario fue exitosa

    if (userCredential.user != null) {
      String userId = userCredential.user!.uid; // Obtiene el ID del usuario

      // Ahora puedes agregar datos adicionales a la colección en Firestore
      await FirebaseFirestore.instance.collection('user').doc(userId).set({
        'nombre': userData.nombre,
        'apellidos': userData.apellidos,
        'telefono': userData.telefono,
        'correoElectronico': userData.correoElectronico,
        'genero': userData.genero,
        'tipo': userData.typeUser
        // Agrega otros campos de datos aquí
      });

      // Registro exitoso, puedes mostrar un mensaje o redirigir al usuario a otra pantalla.
    } else {
      // Handle error: usuario no creado correctamente
      // ignore: use_build_context_synchronously
      Toast.show(context, 'Usuario no creado correctamente');
    }
  } catch (error) {
    // Handle any registration errors here
    // ignore: use_build_context_synchronously
    Toast.show(context, '$error'.toString());
  }
}
