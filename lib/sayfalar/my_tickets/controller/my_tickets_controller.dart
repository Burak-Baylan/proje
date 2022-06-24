import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../base/base_view_model.dart';
import '../../../extensions/context_extensions.dart';
import '../../../main.dart';
import '../../../models/ticket_model.dart';
part 'my_tickets_controller.g.dart';

class MyTicketsViewModel = _MyTicketsViewModelBase with _$MyTicketsViewModel;

abstract class _MyTicketsViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? contextt;

  @override
  void setContext(BuildContext context) => contextt = context;

  List<TicketModel> tickets = [];

  Future<void> getTickets() async {
    var ref = firestore
        .collection('users')
        .doc(globalVm.currentUser!.uid)
        .collection('tickets')
        .orderBy('purchase_date', descending: true);
    var response = await firestoreService.getQuery(ref);
    if (response.error != null) {
      contextt!.pop;
      showErrorAlertDialog('Hata', response.error!.errorMessage!);
      return;
    }
    for (var element in response.data!.docs) {
      var data = element.data();
      var model = TicketModel.fromJson(data);
      tickets.add(model);
    }
  }

  Future<void> showErrorAlertDialog(String title, String message) async {
    await showDialog(
      context: contextt!,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => contextt!.pop,
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }
}
