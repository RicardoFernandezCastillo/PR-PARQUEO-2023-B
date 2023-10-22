import 'dart:developer';

import 'package:bluehpark/models/auth/auth_service.dart';
import 'package:bluehpark/models/coleccion/collection_field.dart';
import 'package:bluehpark/models/coleccion/collections.dart';
import 'package:bluehpark/pages/administrator/accounts_request.dart';
import 'package:bluehpark/pages/client/home_client_page.dart';
import 'package:bluehpark/pages/login/register.dart';
import 'package:bluehpark/pages/owner/form_data/request_data.dart';
import 'package:bluehpark/pages/owner/home_owner_page.dart';
import 'package:bluehpark/utilities/progressbar.dart';
import 'package:bluehpark/utilities/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

class TypeUser extends StatelessWidget {
  const TypeUser({
    Key? key,
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
              margin: const EdgeInsets.only(
                  top: 100), // Espacio de 20 puntos en la parte superior
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RegisterScreen(userType: 'Cliente'),
                      ),
                    );
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
                    try {
                      ProgressDialog.show(context, 'Obteniedo Credenciales...');
                      AuthService authService = AuthService();
                      final User? user = await authService.signInWithGoogle();
                      if (!context.mounted) return;

                      if (user != null) {
                        final firestore = FirebaseFirestore.instance;
                        final document = firestore
                            .collection(Collection.usuarios)
                            .doc(user.uid);
                        final docSnapshot = await document.get();
                        final document2 = firestore
                            .collection(Collection.ownerAccount)
                            .doc(user.uid);
                        final docSnapshot2 = await document2.get();
                        if (docSnapshot.exists) {
                            final data =
                              docSnapshot.data() as Map<String, dynamic>;
                            if(data[UsersCollection.estado]=='habilitado'){
                              if(data['tipo']=="Cliente"){
                                if (!context.mounted) return;
                                ProgressDialog.hide(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeClient(),
                                  ),
                                );
                              }
                              else if (data['tipo']=="Dueño"){
                                  if (!context.mounted) return;
                                  // ignore: use_build_context_synchronously
                                  ProgressDialog.hide(context);
                                  Navigator.push(
                                  context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeOwner(),
                                    ),
                                  );
                              }
                              else if(data['tipo']=="Admin"){
                                  if (!context.mounted) return;
                                  // ignore: use_build_context_synchronously
                                  ProgressDialog.hide(context);
                                  Navigator.push(
                                  context,
                                    MaterialPageRoute(
                                      builder: (context) => const AccountRequestScreen(),
                                    ),
                                  );
                              }
                            }
                            else{
                              if (!context.mounted) return;
                              ProgressDialog.hide(context);
                              Toast.show(context, 'Cuenta Inhabilitada');
                            }
                        } else if (docSnapshot2.exists) {
                          final data =
                              docSnapshot2.data() as Map<String, dynamic>;

                          if (data.containsKey(UsersCollection.correo)) {
                            // El campo 'correo' existe en el documento.
                            if (!context.mounted) return;
                            ProgressDialog.hide(context);
                            Toast.show(context, 'Cuenta pediente de aprobación');
                            // Realiza las acciones que desees en este caso.
                          } else {
                            // El campo 'correo' no existe en el documento.
                            if (!context.mounted) return;
                            ProgressDialog.hide(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RequetFormScreen(userType: 'Dueño'),
                              ),
                            );
                            // Realiza otras acciones aquí.
                          }
                        } else {
                          if (!context.mounted) return;
                          ProgressDialog.hide(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RequetFormScreen(userType: 'Dueño'),
                            ),
                          );
                          // Realiza acciones si el documento no existe.
                        }
                      } else {
                        if (!context.mounted) return;
                        ProgressDialog.hide(context);
                        Toast.show(
                            context, 'error al iniciar sesion con google');
                      }
                    } catch (e) {
                      rethrow;
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

Future<void> checkFieldExists(String documentId) async {
  final firestore = FirebaseFirestore.instance;
  final document = firestore.collection(Collection.usuarios).doc(documentId);
  final docSnapshot = await document.get();

  final document2 =
      firestore.collection(Collection.ownerAccount).doc(documentId);
  final docSnapshot2 = await document2.get();
  if (docSnapshot.exists) {
    //Redireccionar segun el tipo de cliente
  } else if (docSnapshot2.exists) {
    final data = docSnapshot.data() as Map<String, dynamic>;

    if (data.containsKey(UsersCollection.correo)) {
      // El campo 'correo' existe en el documento.
      log('Esta cuenta ya ha solicitado un permiso');
      // Realiza las acciones que desees en este caso.
    } else {
      // El campo 'correo' no existe en el documento.
      log('Debo reenviar al formulario para completar');
      // Realiza otras acciones aquí.
    }
  } else {
    // El documento no existe.
    log('Crear la cuenta');
    // Realiza acciones si el documento no existe.
  }
}
