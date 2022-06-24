import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../extensions/context_extensions.dart';
import '../main.dart';
import '../models/ticket_model.dart';
import '../sayfalar/my_tickets/controller/my_tickets_controller.dart';

class TicketsCell extends StatefulWidget {
  TicketsCell({
    Key? key,
    required this.ticketModel,
    required this.myTicketsVm,
    required this.index,
    required this.onDelete,
  }) : super(key: key);

  TicketModel ticketModel;
  Function onDelete;
  int index;
  MyTicketsViewModel myTicketsVm;

  @override
  State<TicketsCell> createState() => _TicketsCellState();
}

class _TicketsCellState extends State<TicketsCell> {
  TicketModel get ticketModel => widget.ticketModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListTile(
        trailing: InkWell(
          onTap: () {
            widget.myTicketsVm.tickets.removeAt(widget.index);
            widget.onDelete();
            widget.myTicketsVm.firestore
                .collection('users')
                .doc(globalVm.currentUser!.uid)
                .collection('tickets')
                .doc(widget.ticketModel.filmId)
                .delete();
          },
          child: Icon(
            Icons.delete_forever_rounded,
            size: context.width / 35,
            color: Colors.grey[700],
          ),
        ),
        tileColor: Colors.white,
        title: Row(
          children: [
            buildIcon(),
            const SizedBox(width: 10),
            Expanded(child: buildTexts),
          ],
        ),
      ),
    );
  }

  Widget get buildTexts {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            buildTitle('Film Adı: '),
            buildTitle(widget.ticketModel.filmName),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            buildSubtitle('Bilet Tarihi: '),
            buildSubtitle(ticketModel.ticketDate),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            buildSubtitle('Bilet Satın Alım Tarihi: '),
            buildSubtitle(formatDate()),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            buildSubtitle('Bilet Adet: '),
            buildSubtitle(ticketModel.ticketCount.toString()),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  String formatDate() {
    var timeStamp = ticketModel.purchaseDate.toDate();
    var formatted = DateFormat('dd/MM/yyyy').format(timeStamp);
    return formatted;
  }

  Widget buildIcon() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          widget.ticketModel.filmBannerLink,
          width: context.width / 11,
          height: context.width / 8,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget buildTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromARGB(255, 88, 87, 87),
        fontWeight: FontWeight.w600,
        fontSize: context.width / 65,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildSubtitle(String text) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(
        color: Color.fromARGB(255, 166, 166, 166),
        fontWeight: FontWeight.w400,
        fontSize: context.width / 70,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Future<bool> onDismiss() async {
    bool returnBool = false;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: const [
              Icon(Icons.delete),
              SizedBox(width: 5),
              Text('Delete'),
            ],
          ),
          content: Text(ticketModel.filmName),
          actions: getDeleteDialogButtons,
        );
      },
    );
    return returnBool;
  }

  List<Widget> get getDeleteDialogButtons {
    return [
      TextButton(
        onPressed: () {},
        child: Text('Cancel'),
      ),
      TextButton(
        onPressed: () async {},
        child: Text('Delete'),
      ),
    ];
  }

  void showHistoryDetail() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              //Icon(widget.icon),
              SizedBox(width: 5),
              Text('Details'),
            ],
          ),
          content: Text(ticketModel.filmName),
          actions: [
            TextButton(
              onPressed: () => context.pop,
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  /* Widget getDismissibleBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(
        right: context.width(0.03),
      ),
      color: Color(0xFFFF7074),
      child: AutoSizeText(
        "Delete",
        style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: context.getWidth(0.04)),
        maxLines: 1,
      ),
    );
  } */
}
