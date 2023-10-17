import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getTickets() {
  try {
    CollectionReference ticketCollection =
        FirebaseFirestore.instance.collection('ticket');
    return ticketCollection.snapshots();
  } catch (e) {
    return const Stream.empty();
  }
}
