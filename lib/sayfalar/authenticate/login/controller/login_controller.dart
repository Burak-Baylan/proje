import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:proje/base/base_view_model.dart';
import 'package:proje/extensions/context_extensions.dart';
import 'package:proje/main.dart';

import '../../../../widgets/loading_alert_dialog.dart';
part 'login_controller.g.dart';

class LoginViewController = _LoginViewControllerBase with _$LoginViewController;

abstract class _LoginViewControllerBase extends BaseViewModel with Store {
  @override
  BuildContext? contextt;

  @override
  void setContext(BuildContext context) => contextt = context;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String email;
  late String password;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login() async {
    showLoadingAlertDialog(contextt!);
    setCredential();
    if (!formKey.currentState!.validate()) {
      contextt!.pop;
      return;
    }
    var loginResponse = await firebaseAuthService.login(email, password);
    if (loginResponse.error != null) {
      contextt!.pop;
      showErrorAlert(loginResponse.error!.errorMessage!);
      return;
    }
    contextt!.pop;
    showSuccessAlert();
  }

  void setCredential() {
    email = emailController.text;
    password = passwordController.text;
  }

  Future<void> showSuccessAlert() async {
    await showAlert('Başarılı', 'Başarıyla giriş yapıldı.');
    globalVm.changeLoggedInState(true);
    contextt!.pop;
  }

  Future<void> showErrorAlert(String message) async {
    await showAlert('Başarısız', message);
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
