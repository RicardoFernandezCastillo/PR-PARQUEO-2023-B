import 'package:cloud_firestore/cloud_firestore.dart';
//flutter pub add firebase_auth
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
Future<List> getPeople() async {
  List people = [];
  CollectionReference reference = db.collection('user');
  return people;
}
void  Auntenticator() async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'correo@gmail.com',
      password: 'contraseña'
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
