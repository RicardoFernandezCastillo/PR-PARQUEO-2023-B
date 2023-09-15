import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bluehpark/firebase_options.dart';

import 'package:provider/provider.dart';
import './Screens/Login/login_screen.dart';
import './Screens/Login/signup_screen.dart';
import './Screens/Login/welcome_screen.dart';
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
          primarySwatch: Colors.blue,
        ),
        home: CreatePlaceScreen(),
        routes: {
          WelcomeScreen.routeName: (context) => WelcomeScreen(),
          SignupScreen.routeName: (context) => SignupScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          CreatePlaceScreen.routeName: (context) => CreatePlaceScreen()
        },
      ),
    );
  }
}