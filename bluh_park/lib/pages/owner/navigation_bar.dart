import 'package:bluehpark/pages/owner/home_owner_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MenuOwner());

class MenuOwner extends StatefulWidget {
  const MenuOwner({super.key});

  @override
  State<MenuOwner> createState() => _MenuOwnerState();
}

class _MenuOwnerState extends State<MenuOwner> {
  int selectedIndex = 0;

  final List<Widget> pages = <Widget>[
    const HomeOwner(),
    const Text('Reportes'),
    const Text('Notificaciones'),
    const Text('Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bluh Park',
      home: Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            onTap: (index) => setState(() => selectedIndex = index),
            currentIndex: selectedIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.report), label: 'Reortes'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: 'Notificaciones'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil')
            ]),
      ),
    );
  }
}
