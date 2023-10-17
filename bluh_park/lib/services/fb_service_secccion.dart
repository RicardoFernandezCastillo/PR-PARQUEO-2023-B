import 'package:bluehpark/models/seccion_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> createDocumentoASubcoleccion(
    String idParqueo, String idPiso, Map<String, dynamic> datos) async {
  // Obtén una referencia a la colección principal, en este caso, 'parqueos'
  CollectionReference parqueos =
      FirebaseFirestore.instance.collection('parqueo');
  // Obtén una referencia al documento del parqueo
  DocumentReference parqueoDocRef = parqueos.doc("ID-PARQUEO-3");
  // Obtén una referencia a la subcolección 'pisos' dentro del documento del parqueo
  CollectionReference pisos = parqueoDocRef.collection('pisos');
  // Obtén una referencia al documento del piso
  DocumentReference pisoDocRef = pisos.doc('ID-PISO-1');
  // Obtén una referencia a la subcolección 'filas' dentro del documento del piso
  CollectionReference filas = pisoDocRef.collection('filas');
  // Usa set para agregar el documento con los datos proporcionados
  await filas.doc().set(datos);
}

Future<void> editSeccion(String idParqueo, String idPiso, String idFila,
    Map<String, dynamic> datos) async {
  try {
    // Obtén una referencia al documento de la plaza que deseas editar
    DocumentReference seccionDocRef = FirebaseFirestore.instance
        .collection('parqueo')
        .doc(idParqueo)
        .collection('pisos')
        .doc(idPiso)
        .collection('filas')
        .doc(idFila);
    // Utiliza update para modificar campos existentes o set con merge: true para combinar datos nuevos con los existentes
    await seccionDocRef.update(
        datos); // Utiliza update para modificar campos existentes o set con merge: true
  } catch (e) {
    print('Error al editar la plaza: $e');
  }
}

Future<List<Seccion>> getSeccions(
    String idParqueo, String idPiso, String idFila) async {
  try {
    CollectionReference seccionCollection = FirebaseFirestore.instance
        .collection('parqueo')
        .doc(idParqueo)
        .collection('pisos')
        .doc(idPiso)
        .collection('filas');
    QuerySnapshot querySnapshot = await seccionCollection.get();
    // Mapea los documentos en objetos de la clase Plaza
    List<Seccion> seccions =
        querySnapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      return Seccion(idFila, data['nombre'], data['descripcion']);
    }).toList();
    return seccions;
  } catch (e) {
    print('Error al obtener las Filas: $e');
    return [];
  }
}

Stream<QuerySnapshot> getSeccionsStream(String idParqueo, String idPiso) {
  try {
    CollectionReference seccionCollection = FirebaseFirestore.instance
        .collection('parqueo')
        .doc(idParqueo)
        .collection('pisos')
        .doc(idPiso)
        .collection('filas');
    return seccionCollection
        .snapshots(); // Devuelve un Stream que escucha cambios en la colección.
  } catch (e) {
    print('Error al obtener el Stream de Filas: $e');
    throw e;
  }
}
