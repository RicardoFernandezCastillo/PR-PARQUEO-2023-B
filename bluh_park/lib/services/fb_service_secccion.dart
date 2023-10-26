import 'package:bluehpark/models/seccion_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> createDocumentoASubcoleccion(
    DocumentReference pisoRef, Map<String, dynamic> datos) async {
  // Obtén una referencia a la subcolección 'filas' dentro del documento del piso
  CollectionReference filas = pisoRef.collection('filas');
  // Usa set para agregar el documento con los datos proporcionados
  await filas.doc().set(datos);
}

Future<void> editSeccion(DocumentReference seccionRef,
    Map<String, dynamic> datos) async {
  try {
    // Utiliza update para modificar campos existentes o set con merge: true para combinar datos nuevos con los existentes
    await seccionRef.update(
        datos); // Utiliza update para modificar campos existentes o set con merge: true
  } catch (e) {
    print('Error al editar la plaza: $e');
  }
}

// Future<List<Seccion>> getSeccions(
//     String idParqueo, String idPiso, String idFila) async {
//   try {
//     CollectionReference seccionCollection = FirebaseFirestore.instance
//         .collection('parqueo')
//         .doc(idParqueo)
//         .collection('pisos')
//         .doc(idPiso)
//         .collection('filas');
//     QuerySnapshot querySnapshot = await seccionCollection.get();
//     // Mapea los documentos en objetos de la clase Plaza
//     List<Seccion> seccions =
//         querySnapshot.docs.map((DocumentSnapshot document) {
//       Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//       return Seccion(document.reference, data['nombre'], data['descripcion']);
//     }).toList();
//     return seccions;
//   } catch (e) {
//     print('Error al obtener las Filas: $e');
//     return [];
//   }
// }

Stream<QuerySnapshot> getSeccionsStream(DocumentReference pisoRef) {
  try {
    CollectionReference seccionCollection = pisoRef
        .collection('filas');
    return seccionCollection
        .snapshots(); // Devuelve un Stream que escucha cambios en la colección.
  } catch (e) {
    print('Error al obtener el Stream de Filas: $e');
    throw e;
  }
}
