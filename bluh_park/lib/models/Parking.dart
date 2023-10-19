import 'package:cloud_firestore/cloud_firestore.dart';

class Parking {
  late String idParking;
  late String name;
  late String description;
  late String direccion;
  late GeoPoint ubicacion;
  late bool tieneCobertura;
  late Map<String, dynamic> vehiculosPermitidos; //BOOL
  late String nit;
  late Map<String, dynamic> tarifaMoto; //DOUBLE
  late Map<String, dynamic> tarifaAutomovil; //DOUBLE
  late Map<String, dynamic> tarifaOtro; //DOUBLE
  late Timestamp horaApertura;
  late Timestamp horaCierre;
  late String idDuenio;

  Parking({
    required this.idParking,
    required this.name,
    required this.description,
    required this.direccion,
    required this.ubicacion,
    required this.tieneCobertura,
    required this.vehiculosPermitidos,
    required this.nit,
    required this.tarifaMoto,
    required this.tarifaAutomovil,
    required this.tarifaOtro,
    required this.horaApertura,
    required this.horaCierre,
    required this.idDuenio,
  });
}

class VeiculosPermitidos {
  late bool auto;
  late bool moto;
  late bool otros;

  VeiculosPermitidos({
    required this.auto,
    required this.moto,
    required this.otros,
  });
}
