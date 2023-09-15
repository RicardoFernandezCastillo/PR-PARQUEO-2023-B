import 'package:flutter/material.dart';

import '../parking_space/create_place.dart';

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            Container(
                height: 80,
                width: 250, //corregir no dinamico****
                padding:
                    const EdgeInsets.only(top: 25, left: 24, right: 24),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(CreatePlaceScreen.routeName),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),

                    //backgroundColor: Colors.indigo,

                    //color: Colors.indigo,
                  ),
                  child: const Text(
                    'Agregar nueva Plaza',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
                    
          ],
        ) 
        
        
      ),
    );
  }
}
