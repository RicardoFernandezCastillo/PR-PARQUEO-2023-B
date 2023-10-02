import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/auth.dart';
import 'package:test_project/firebase_options.dart';
//import 'vistaPiso.dart'; // Importa la primera pantalla
import 'agregarPiso.dart'; 
import 'registroParqueo.dart';
import 'vistaParqueo.dart';// Importa la segunda pantalla
import 'registroReserva.dart';
import 'vistaParqueoDisponible.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: '/',
//       routes: {
//         '/': (context) => RegistroParqueoScreen(),
//         '/agregar_piso': (context) => AgregarPisoScreen(),
//       },
//     );
//   }
// }




void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

  );

  runApp(const MyApp());

}

 

// class MyApp extends StatelessWidget {

//   const MyApp({super.key});

//   @override

//   Widget build(BuildContext context) {

//     return ChangeNotifierProvider(

//       create: (ctx) => Auth(),

//       child: MaterialApp(

//         debugShowCheckedModeBanner: false,

//         theme: ThemeData(

//           primarySwatch: Colors.blue,

//         ),

//         home: CreateParqueoScreen(),

//         routes: {

//           CreateParqueoScreen.routeName: (context) => CreateParqueoScreen(),
//         },

//       ),

//     );

//   }

// }


// class MyApp extends StatelessWidget {

//   const MyApp({super.key});

//   @override

//   Widget build(BuildContext context) {

//     return ChangeNotifierProvider(

//       create: (ctx) => Auth(),

//       child: MaterialApp(

//         debugShowCheckedModeBanner: false,

//         theme: ThemeData(

//           primarySwatch: Colors.blue,

//         ),

//         home: CreateReservaScreen(),

//         routes: {

//           CreateReservaScreen.routeName: (context) => CreateReservaScreen(),
//         },

//       ),

//     );

//   }

// }


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {

    return ChangeNotifierProvider(

      create: (ctx) => Auth(),

      child: MaterialApp(

        debugShowCheckedModeBanner: false,

        theme: ThemeData(

          primarySwatch: Colors.blue,

        ),

        home: ParqueoDisponibleListScreen(),

        routes: {

          ParqueoDisponibleListScreen.routeName: (context) => ParqueoDisponibleListScreen(),
        },

      ),

    );

  }

}
