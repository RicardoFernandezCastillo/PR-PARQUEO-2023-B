import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getParkingsByOwner(String ownerId) {
  return FirebaseFirestore.instance
      .collection('parqueo')
      .where('idDuenio', isEqualTo: ownerId)
      .snapshots();
}

Stream<QuerySnapshot> getAllParkings() {
  return FirebaseFirestore.instance.collection('parqueo').snapshots();
}
