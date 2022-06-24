import 'package:flutter/material.dart';
import '../../../widgets/tickets_cell.dart';
import '../controller/my_tickets_controller.dart';

class MyTicketsView extends StatefulWidget {
  const MyTicketsView({Key? key}) : super(key: key);

  @override
  State<MyTicketsView> createState() => _MyTicketsViewState();
}

class _MyTicketsViewState extends State<MyTicketsView> {
  MyTicketsViewModel myTicketsVm = MyTicketsViewModel();
  late Future ticketsFuture;

  @override
  void initState() {
    ticketsFuture = myTicketsVm.getTickets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 47, 63),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 110, 122),
        centerTitle: true,
        title: const Text('Biletlerim'),
      ),
      body: FutureBuilder(
        future: ticketsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (myTicketsVm.tickets.isNotEmpty) {
              return buildTicketsList();
            }
            return buildNoTicketWidget;
          }
          if (snapshot.hasError) {
            return buildErrorWidget;
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget get buildNoTicketWidget {
    return const Center(
      child: Text(
        'Aktif biletin yok',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget get buildErrorWidget {
    return const Center(
      child: Text(
        'Hata!',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildTicketsList() {
    return ListView.builder(
      itemCount: myTicketsVm.tickets.length,
      itemBuilder: (context, index) {
        var model = myTicketsVm.tickets[index];
        return TicketsCell(
          ticketModel: model,
          index: index,
          myTicketsVm: myTicketsVm,
          onDelete: () => setState(() {}),
        );
      },
    );
  }
}
