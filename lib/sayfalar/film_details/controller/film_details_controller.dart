import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import '../../../base/base_view_model.dart';
import '../../../extensions/context_extensions.dart';
import '../../../main.dart';
import '../../../models/film_model.dart';
import '../../../models/ticket_model.dart';
import '../../../widgets/loading_alert_dialog.dart';
import '../../authenticate/login/view/login_view.dart';
part 'film_details_controller.g.dart';

class FilmDetailsController = _FilmDetailsControllerBase
    with _$FilmDetailsController;

abstract class _FilmDetailsControllerBase extends BaseViewModel with Store {
  @override
  BuildContext? contextt;

  @override
  void setContext(BuildContext context) => contextt = context;

  late DateTime ticketDate;
  late int ticketCount;
  late FilmModel filmModel;
  late String stringDate;

  Future<void> buyTicked(
      DateTime date, int ticketCount, FilmModel filmModel) async {
    print('$date :: $ticketCount :: $filmModel');
    if (globalVm.auth.currentUser == null) {
      await showLoginAlert();
      contextt!.pop;
      return;
    }
    ticketDate = date;
    this.ticketCount = ticketCount;
    this.filmModel = filmModel;
    changeDateFormat();
    await buyDialog();
  }

  void changeDateFormat() {
    stringDate = DateFormat('dd/MM/yyyy').format(ticketDate);
  }

  Future<void> buyDialog() async {
    await showDialog(
      context: contextt!,
      builder: (context) {
        return AlertDialog(
          title: Text('Satın al'),
          content: Text(
              '${filmModel.name} filmi için $stringDate tarihine $ticketCount tane bilet almak istediğinden emin misin?'),
          actions: [
            TextButton(
              onPressed: () => context.pop,
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                context.pop;
                buy();
              },
              child: Text('Satın Al'),
            ),
          ],
        );
      },
    );
  }

  Future<void> buy() async {
    showLoadingAlertDialog(contextt!);
    var ref = firestore
        .collection('users')
        .doc(globalVm.currentUser!.uid)
        .collection('tickets')
        .doc(filmModel.filmId);
    var response =
        await firestoreService.addDocument(ref, getTicketModel().toJson());
    if (response.errorMessage != null) {
      contextt!.pop;
      ticketBuyErrorAlert();
      return;
    }
    contextt!.pop;
    contextt!.pop;
    await tictetBuySuccessAlert();
  }

  TicketModel getTicketModel() {
    return TicketModel(
      filmId: filmModel.filmId,
      userId: globalVm.currentUser!.uid,
      ticketCount: ticketCount,
      ticketDate: stringDate,
      filmName: filmModel.name,
      filmBannerLink: filmModel.bannerLink,
      purchaseDate: Timestamp.now(),
    );
  }

  Future<void> tictetBuySuccessAlert() async {
    await showDialog(
      context: contextt!,
      builder: (context) {
        return AlertDialog(
          title: Text('Başarılı'),
          content: Text(
              'Bileti başarıyla satın aldın. Profiline girip biletlerim kısmından aktif biletlerini görebilirsin.'),
          actions: [
            TextButton(
              onPressed: () => context.pop,
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  Future<void> ticketBuyErrorAlert() async {
    await showDialog(
      context: contextt!,
      builder: (context) {
        return AlertDialog(
          title: Text('Hata'),
          content: Text(
              'Bilet alımı sırasında bir hata oldu. Lütfen tekrar deneyin.'),
          actions: [
            TextButton(
              onPressed: () => context.pop,
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showLoginAlert() async {
    await showDialog(
      context: contextt!,
      builder: (context) {
        return AlertDialog(
          title: Text('Giriş Yap'),
          content: Text('Bilet satın almak için hesabına giriş yapman gerek.'),
          actions: [
            TextButton(
              onPressed: () => context.pop,
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () => globalVm.sendToPage(context, LoginView()),
              child: Text('Giriş Yap'),
            ),
          ],
        );
      },
    );
  }
}
