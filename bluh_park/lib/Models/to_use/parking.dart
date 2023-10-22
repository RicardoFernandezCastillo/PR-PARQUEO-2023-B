import 'package:cloud_firestore/cloud_firestore.dart';

class Plaza {
  final DocumentReference idPlaza;
  String nombre;
  bool tieneCobertura;
  String estado;
  Plaza({
    required this.idPlaza,
    required this.nombre,
    required this.tieneCobertura,
    required this.estado,
  });
}

class Piso {
  final DocumentReference idPiso;
  final String nombre;
  final String descripcion;
  List<Fila> filas;
  Piso({
    required this.idPiso,
    required this.descripcion,
    required this.nombre,
    List<Fila>? filas, // Usamos List<Fila>? para permitir un valor nulo
  }) : filas =
            filas ?? []; // Si filas es nulo, inicializamos con una lista vacía
}

class Fila {
  final DocumentReference idFila;
  final String nombre;
  final String descripcion;

  List<Plaza> plazas;
  Fila(
      {required this.nombre,
      required this.descripcion,
      required this.idFila,
      List<Plaza>? plazas})
      : plazas = plazas ?? [];
}

class Parqueo {
  final DocumentReference idParqueo;
  String nombre;
  String direccion;
  final GeoPoint ubicacion;
  bool tieneCobertura;
  String descripcion;
  final Map<String, dynamic> vehiculosPermitidos; // BOOL
  final String nit;
  Map<String, dynamic> tarifaMoto; // DOUBLE
  Map<String, dynamic> tarifaAutomovil; // DOUBLE
  Map<String, dynamic> tarifaOtro; // DOUBLE
  Timestamp horaApertura;
  Timestamp horaCierre;
  final String idDuenio;
  List<Piso> pisos;

  Parqueo({
    required this.idParqueo,
    required this.nombre,
    required this.direccion,
    required this.ubicacion,
    required this.tieneCobertura,
    required this.descripcion,
    required this.vehiculosPermitidos,
    required this.nit,
    required this.tarifaAutomovil,
    required this.tarifaMoto,
    required this.tarifaOtro,
    required this.horaApertura,
    required this.horaCierre,
    required this.idDuenio,
    List<Piso>? pisos, // Parámetro con nombre para filas, opcional
  }) : pisos = pisos ??
            <Piso>[]; // Inicializa con una lista vacía si no se proporciona
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

