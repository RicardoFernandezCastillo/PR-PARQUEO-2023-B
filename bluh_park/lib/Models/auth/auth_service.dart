import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      // Iniciar sesión con Google
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      final UserCredential authResult = await _auth.signInWithCredential(credential);

      // Obtener el usuario autenticado
      final User? user = authResult.user;

      // Verificar si el usuario ya existe en la base de datos
      // final userExists = await _firestore.collection(Collection.usuarios).doc(user!.uid).get();
      // if (!userExists.exists) {
      //   // Si el usuario no existe, crea un nuevo documento en Firestore
      //   await _firestore.collection(Collection.usuarios).doc(user.uid).set({
      //     'nombreCuenta': user.displayName,
      //     UsersCollection.correo: user.email,
      //     // Agrega otros campos según tus necesidades
      //   });
      // }

      return user;
    } catch (e) {
      log('Error al iniciar sesión con Google: $e');
      return null;
    }
  }
  Future<User?> signInWithGoogleLogin() async {
    try {
      // Iniciar sesión con Google
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      final UserCredential authResult = await _auth.signInWithCredential(credential);

      // Obtener el usuario autenticado
      final User? user = authResult.user;

      // Verificar si el usuario ya existe en la base de datos
      // final userExists = await _firestore.collection(Collection.usuarios).doc(user!.uid).get();
      // if (!userExists.exists) {
      //   // Si el usuario no existe, crea un nuevo documento en Firestore
      //   await _firestore.collection(Collection.usuarios).doc(user.uid).set({
      //     'nombreCuenta': user.displayName,
      //     UsersCollection.correo: user.email,
      //     // Agrega otros campos según tus necesidades
      //   });
      // }
      return user;
    } catch (e) {
      log('Error al iniciar sesión con Google: $e');
      return null;
    }
  }
}

