import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_create_account/user_section/details_reserve.dart';
import 'package:flutter_create_account/user_section/search_parking_spaces.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/register', // Ruta inicial a 'register.dart'
      routes: {
        '/register': (context) => const ReservationDetails(), // Define la ruta '/register'
      },
    );
  }
}
