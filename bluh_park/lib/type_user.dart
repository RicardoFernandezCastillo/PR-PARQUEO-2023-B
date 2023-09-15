import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_create_account/register.dart';

class TypeUser extends StatelessWidget {
  final UserData userData;
  const TypeUser({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text(
          'Tipo de Cuenta',
          style: TextStyle(fontSize: 25),
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
              margin: const EdgeInsets.only(top: 100), // Espacio de 20 puntos en la parte superior
              child: Center(
                child: ElevatedButton(
                  onPressed: () async{
                    // Acción cuando se presiona el botón
                    try {
                      ProgressDialog.show(context,
                          'Registrando usuario...'); // Muestra el diálogo de progreso
                      await registerUser(userData, 'Dueño');
                      
                      // ignore: use_build_context_synchronously
                      ProgressDialog.hide(
                          context);
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
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Usuario común - Realiza    ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'reserva de parqueos',
                        style: TextStyle(
                          fontSize: 18,
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
                  top: 100), // Espacio de 20 puntos en la parte superior
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Acción cuando se presiona el botón
                    try {
                      ProgressDialog.show(context,
                          'Registrando usuario...'); // Muestra el diálogo de progreso
                      await registerUser(userData, 'Dueño');
                      
                      // ignore: use_build_context_synchronously
                      ProgressDialog.hide(
                          context); // Oculta el diálogo de progreso después de completar la tarea
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
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Usuario Gestor - Realiza la',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'gestion de su parqueo',
                        style: TextStyle(
                          fontSize: 18,
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


Future<void> registerUser(UserData userData, String typeUser) async {
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
        'tipo': typeUser
        // Agrega otros campos de datos aquí
      });

      // Registro exitoso, puedes mostrar un mensaje o redirigir al usuario a otra pantalla.
    } else {
      // Handle error: usuario no creado correctamente
      print('Usuario no creado correctamente');
    }
  } catch (error) {
    // Handle any registration errors here
    print('$error');
  }
}

class ProgressDialog {
  static show(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(width: 20),
          Text(message),
        ],
      ),
    );

    showDialog(
      context: context,
      barrierDismissible:
          false, // Evita que el usuario cierre el diálogo tocando fuera de él
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static hide(BuildContext context) {
    Navigator.of(context).pop(); // Cierra el diálogo de progreso
  }
}

class Toast {
  static void show(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: Text(
          message,
          style: const TextStyle(fontSize: 18),
        ),
        action: SnackBarAction(
          label: 'Cerrar',
          onPressed: scaffold.hideCurrentSnackBar,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
