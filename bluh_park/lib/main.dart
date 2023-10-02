import 'package:bluehpark/screens/User/Parking/enable_place.dart';
import 'package:bluehpark/screens/User/Parking/nearby_parking.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bluehpark/firebase_options.dart';
import 'package:provider/provider.dart';
import 'screens/Login/login_screen.dart';
import 'screens/Login/signup_screen.dart';
import 'screens/Login/welcome_screen.dart';
import './Models/auth.dart';
import './screens/parking_space/create_place.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color.fromARGB(255, 2, 51, 135)
        ),
        home: CreatePlaceScreen(),
        routes: {
          WelcomeScreen.routeName: (context) => WelcomeScreen(),
          SignupScreen.routeName: (context) => SignupScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          CreatePlaceScreen.routeName: (context) => const CreatePlaceScreen(),
          SelectParkingScreen.routeName:(context) => const SelectParkingScreen(),
          SelectSpaceScreen.routeName:(context) => const SelectSpaceScreen(),
        },
      ),
    );
  }
}