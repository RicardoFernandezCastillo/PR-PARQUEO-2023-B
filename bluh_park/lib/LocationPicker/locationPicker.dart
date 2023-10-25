import 'package:flutter/material.dart';
import 'package:flutter_map_location_picker/flutter_map_location_picker.dart';
import 'package:latlong2/latlong.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({Key? key}) : super(key: key);

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  String address = '';
  LocationResult? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Seleccione una localización',
            style: TextStyle(fontFamily: 'Urbanist', fontSize: 25),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          toolbarHeight: 60,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 200,
            child: Center(child: Text(address)),
          ),
          SizedBox(
            height: 500,
            child: MapLocationPicker(
              initialLocation:
                  const LatLng(-17.396843874763828, -66.16765210043515),
              onPicked: (pickedData) {
                setState(() {
                  address = pickedData.address +
                      pickedData.latitude.toString() +
                      pickedData.longitude.toString();
                });
                print(pickedData.latitude);
                print(pickedData.longitude);
                print(pickedData.address);
              },
            ),
          ),
        ])));
  }
}
