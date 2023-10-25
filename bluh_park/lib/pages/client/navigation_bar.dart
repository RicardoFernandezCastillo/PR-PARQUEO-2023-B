import 'package:bluh_park/pages/client/home_client_page.dart';
import 'package:bluh_park/pages/client/ticket_list_page.dart';
import 'package:bluh_park/pages/profile.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MenuClient());

class MenuClient extends StatefulWidget {
  const MenuClient({super.key});

  @override
  State<MenuClient> createState() => _MenuClientState();
}

class _MenuClientState extends State<MenuClient> {
  int selectedIndex = 0;

  final List<Widget> pages = <Widget>[
    const HomeClient(),
    const TicketsList(),
    const Text('Notificaciones de reserva'),
    const ProfilePage(),
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
                  icon: Icon(Icons.calendar_today_rounded), label: 'Tickets'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: 'Notificaciones'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil')
            ]),
      ),
    );
  }
}
