import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> agregarDocumentoASubcoleccion(String idParqueo, String idPiso, String idFila, Map<String, dynamic> datos) async {
  // Obtén una referencia a la colección principal, en este caso, 'parqueos'
  CollectionReference parqueos = FirebaseFirestore.instance.collection('parqueos');

  // Obtén una referencia al documento del parqueo
  DocumentReference parqueoDocRef = parqueos.doc(idParqueo);

  // Obtén una referencia a la subcolección 'pisos' dentro del documento del parqueo
  CollectionReference pisos = parqueoDocRef.collection('pisos');

  // Obtén una referencia al documento del piso
  DocumentReference pisoDocRef = pisos.doc(idPiso);

  // Obtén una referencia a la subcolección 'filas' dentro del documento del piso
  CollectionReference filas = pisoDocRef.collection('filas');

  // Obtén una referencia al documento de la fila
  DocumentReference filaDocRef = filas.doc(idFila);

  // Agrega el documento con los datos proporcionados a la subcolección 'plazas' dentro del documento de la fila
  await filaDocRef.collection('plazas').add(datos);
}

// Future<Parqueo> obtenerParqueoDesdeFirestore(String idParqueo) async {
//   DocumentSnapshot parqueoDocument =
//       await FirebaseFirestore.instance.collection('parqueos').doc(idParqueo).get();

//   if (parqueoDocument.exists) {
//     // Obtener los datos principales del documento Parqueo
//     Map<String, dynamic> parqueoData = parqueoDocument.data() as Map<String, dynamic>;

//     // Crear un objeto Parqueo con los datos principales
//     Parqueo parqueo = Parqueo(
//       nombre: parqueoData['nombre'],
//       latitud: parqueoData['latitud'],
//       longitud: parqueoData['longitud'],
//       horaApertura: parqueoData['horaApertura'],
//       horaCierre: parqueoData['horaCierre'],
//       nit: parqueoData['nit'],
//       descripcion: parqueoData['descripcion'],
//       idDueño: parqueoData['idDueño'],
//     );

//     // Obtener la subcolección de Pisos
//     QuerySnapshot pisosSnapshot = await parqueoDocument.reference.collection('pisos').get();

//     // Recorrer los documentos de Pisos y agregarlos al objeto Parqueo
//     for (QueryDocumentSnapshot pisoDocument in pisosSnapshot.docs) {
//       Piso piso = Piso(
//         nombre: pisoDocument['nombre'],
//         idParqueo: pisoDocument['idParqueo'],
//       );

//       // Obtener la subcolección de Filas para este Piso
//       QuerySnapshot filasSnapshot =
//           await pisoDocument.reference.collection('filas').get();

//       // Recorrer los documentos de Filas y agregarlos al objeto Piso
//       for (QueryDocumentSnapshot filaDocument in filasSnapshot.docs) {
//         Fila fila = Fila(
//           nombre: filaDocument['nombre'],
//           idPiso: filaDocument['idPiso'],
//         );

//         // Obtener la subcolección de Plazas para esta Fila
//         QuerySnapshot plazasSnapshot =
//             await filaDocument.reference.collection('plazas').get();

//         // Recorrer los documentos de Plazas y agregarlos al objeto Fila
//         for (QueryDocumentSnapshot plazaDocument in plazasSnapshot.docs) {
//           Plaza plaza = Plaza(
//             nombre: plazaDocument['nombre'],
//             horaApertura: plazaDocument['horaApertura'],
//             horaCierre: plazaDocument['horaCierre'],
//             idPiso: plazaDocument['idPiso'],
//           );

//           fila.plazas.add(plaza);
//         }

//         piso.filas.add(fila);
//       }

//       parqueo.pisos.add(piso);
//     }

//     return parqueo;
//   } else {
//     throw Exception('El parqueo con ID $idParqueo no existe.');
//   }
// }


// class Usuario {
//   String id;
//   String nombre;
//   String tipo; // 'dueño' o 'cliente'
//   // Otros campos de usuario
// }

// class Parqueo {
//   String id;
//   String nombre;
//   double latitud;
//   double longitud;
//   String horaApertura;
//   String horaCierre;
//   String nit;
//   String descripcion;
//   List<Tarifa> tarifas;
//   List<Piso> pisos;
// }

// class Tarifa {
//   double precioHora;
//   double precioDia;
//   String tipoVehiculo;
// }

// class Piso {
//   String nombre;
//   String descripcion;
//   List<Fila> filas;
// }

// class Fila {
//   late String nombre;
//   late String descripcion;
//   late List<Plaza> plazas;
// }

// class Plaza {
//   late String nombre;
//   late String tipoVehiculo;
//   late bool tieneCobertura;
// }

// class Reserva {
//   late String clienteId;
//   late String parqueoId;
//   late DateTime fechaHoraInicio;
//   late DateTime fechaHoraFin;
//   late String plazaReservada;
//   late String estado;
//   // Otros campos de reserva
// }

