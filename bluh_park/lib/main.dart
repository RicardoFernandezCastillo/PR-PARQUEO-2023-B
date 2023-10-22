import 'dart:html';

import 'package:bluh_park/pages/client/navigation_bar.dart';
import 'package:bluh_park/pages/map/map_client.dart';
import 'package:bluh_park/pages/map/map_owner.dart';
import 'package:bluh_park/pages/owner/navigation_bar.dart';
import 'package:bluh_park/pages/seccion/seccion_create.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bluh Park',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const MenuOwner(),
        '/map/client': (context) => const MapClient(),
        '/home/owner': (context) => const MenuOwner(),
        '/home/client': (context) => const MenuClient(),
        '/seccion/create': (context) => const SeccionCreate(),
      },
    );
  }
}
