import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({Key? key}) : super(key: key);

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  String address = '';
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
              child: OpenStreetMapSearchAndPick(
                  center: LatLong(23, 89),
                  onPicked: (pickedData) {
                    setState(() {
                      address = pickedData.addressName +
                          pickedData.latLong.latitude.toString() +
                          pickedData.latLong.longitude.toString();
                    });
                    print(pickedData.latLong.latitude);
                    print(pickedData.latLong.longitude);
                    print(pickedData.address);
                  }))
        ])));
  }
}
