import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mobx/mobx.dart';
import '../../../base/base_view_model.dart';
import '../../../extensions/context_extensions.dart';
import '../../../main.dart';
import '../../../widgets/loading_alert_dialog.dart';
part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase extends BaseViewModel with Store {
  @override
  BuildContext? contextt;

  @override
  void setContext(BuildContext context) => contextt = context;

  Future<void> sendPasswordResetEmail() async {
    askAreYouWantToSendPasswordResetEmail();
  }

  void askAreYouWantToSendPasswordResetEmail() {
    showDialog(
      context: contextt!,
      builder: (context) {
        return AlertDialog(
          title: const Text('E-Posta Gönder'),
          content: const Text(
              'Sistemde kayıtlı olan E-Postana bir şifre yenileme E-Postası göndermemizi istiyor musun?'),
          actions: [
            TextButton(
              onPressed: () => contextt!.pop,
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                contextt!.pop;
                sendMail();
              },
              child: Text('Gönder'),
            ),
          ],
        );
      },
    );
  }

  Future<void> sendMail() async {
    showLoadingAlertDialog(contextt!);
    var response =
        await authService.sendPasswordResetEmail(globalVm.currentUser!.email!);
    if (response.errorMessage != null) {
      contextt!.pop;
      await showPasswordResetEmailErrorAlert(response.errorMessage!);
      return;
    }
    contextt!.pop;
    await showPasswordResetEmailSuccessAlert();
  }

  Future<void> showPasswordResetEmailSuccessAlert() async {
    await showAlert(
      'E-Posta Gönderildi',
      'E-Posta gönderildi. Lütfen E-Posta kutunu kontrol et.',
    );
  }

  Future<void> showPasswordResetEmailErrorAlert(String message) async {
    await showAlert('Hata', message);
  }

  Future<void> logoutAlert() async {
    await showDialog(
      context: contextt!,
      builder: (context) {
        return AlertDialog(
          title: Text('Çıkış Yap'),
          content: Text('Çıkış yapmak istediğinden emin misin?'),
          actions: [
            TextButton(
              onPressed: () => contextt!.pop,
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                contextt!.pop;
                logout();
              },
              child: Text('Evet'),
            ),
          ],
        );
      },
    );
  }

  Future<void> logout() async {
    showLoadingAlertDialog(contextt!);
    await globalVm.auth.signOut();
    globalVm.changeLoggedInState(false);
    contextt!.pop;
    Get.back();
  }

  Future<void> showAlert(String title, String message) async {
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
