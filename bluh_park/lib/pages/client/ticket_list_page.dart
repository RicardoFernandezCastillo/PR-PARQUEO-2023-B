import 'package:bluehpark/models/ticket_class.dart';
import 'package:bluehpark/pages/client/ticket_detail.dart';
import 'package:bluehpark/services/fb_service_ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(const TicketsList());

// ignore: must_be_immutable
class TicketsList extends StatefulWidget {
  const TicketsList({super.key});

  @override
  State<TicketsList> createState() => _TicketsListState();
}

class _TicketsListState extends State<TicketsList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        title: 'Bluh Park',
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Tickets de parqueo',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            backgroundColor: Colors.blue,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Expanded(
              flex: 1,
              child: StreamBuilder(
                stream: getTickets(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  List<Ticket> tickets =
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    String idDocumento = document.id;
                    return Ticket(
                        idTicket: idDocumento,
                        brand: data['brand'],
                        date: data['date'].toDate(),
                        dateArrive: data['dateArrive'].toDate(),
                        dateOut: data['dateOut'].toDate(),
                        model: data['model'],
                        plate: data['plate'],
                        status: data['status'],
                        total: data['total'],
                        typeVehicle: data['typeVehicle']);
                  }).toList();
                  return ListView.builder(
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = tickets[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailTicket(
                                ticket: ticket,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(ticket.brand),
                          subtitle: Text(ticket.date.toString()),
                          leading: CircleAvatar(
                            child: Text(ticket.brand[0]),
                          ),
                          trailing: Text(ticket.status),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ));
  }
}
