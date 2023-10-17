import 'package:bluehpark/models/ticket_class.dart';
import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';


// ignore: must_be_immutable
class DetailTicket extends StatefulWidget {
  Ticket ticket;
  DetailTicket({super.key, required this.ticket});

  @override
  State<DetailTicket> createState() => _DetailTicketState();
}

class _DetailTicketState extends State<DetailTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
          title: const Text('Detalle',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: TicketWidget(
              width: 350,
              height: 500,
              isCornerRounded: true,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 120,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1, color: Colors.blue)),
                          child: const Center(
                            child: Text(
                              'Ticket # 0001',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        Text('SLM-0001',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(
                            Icons.car_rental,
                            color: Colors.pink,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'BTL',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(widget.ticket.brand.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: <Widget>[
                            ticketDetails('Modelo', widget.ticket.model,
                                '# Número de Placa', widget.ticket.plate),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, right: 40),
                              child: ticketDetails(
                                  'Fecha',
                                  widget.ticket.date
                                      .toString()
                                      .substring(0, 10),
                                  'Tipo de vehículo',
                                  widget.ticket.typeVehicle),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, right: 40),
                              child: ticketDetails(
                                  'Fecha de llegada',
                                  widget.ticket.dateArrive
                                      .toString()
                                      .substring(0, 10),
                                  'Fecha de salida',
                                  widget.ticket.dateOut
                                      .toString()
                                      .substring(0, 10)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, right: 40),
                              child: ticketDetails(
                                  'Total a pagar',
                                  widget.ticket.total.toString(),
                                  'Estado ticket',
                                  widget.ticket.status),
                            )
                          ],
                        )),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 40, left: 30, right: 30),
                      child: Container(
                        width: 250,
                        height: 60,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/barcode.png'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 75, right: 75),
                      child: Text(
                        '9824 0972 1742 1298',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}

Widget ticketDetails(String firstTitle, String firstDesc, String secondTitle,
    String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                firstDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              secondTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                secondDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      )
    ],
  );
}
