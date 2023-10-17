import 'package:bluehpark/pages/login/login_screen.dart';
import 'package:bluehpark/pages/login/register.dart';
import 'package:bluehpark/pages/login/signup_screen.dart';
import 'package:bluehpark/pages/login/welcome_screen.dart';
import 'package:bluehpark/pages/owner/parking/registroParqueo.dart';
import 'package:bluehpark/pages/client/reservation/search_parking_spaces.dart';
import 'package:bluehpark/pages/client/reservation/enable_place.dart';
import 'package:bluehpark/pages/client/reservation/nearby_parking.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bluehpark/firebase_options.dart';
import 'package:provider/provider.dart';
import 'models/auth.dart';
import 'pages/owner/place/create_place.dart';

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
        home: WelcomeScreen(),
        routes: {
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          WelcomeScreen.routeName: (context) => WelcomeScreen(),
          SignupScreen.routeName: (context) => SignupScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          
          CreatePlaceScreen.routeName: (context) => const CreatePlaceScreen(),
          SelectParkingScreen.routeName:(context) => const SelectParkingScreen(),
          SelectSpaceScreen.routeName:(context) => const SelectSpaceScreen(),

          RegistroParqueoScreen.routeName: (context) => const RegistroParqueoScreen(),


          SearchPlaceScreen.routeName:(context) => const SearchPlaceScreen(),
        },
      ),
    );
  }
}