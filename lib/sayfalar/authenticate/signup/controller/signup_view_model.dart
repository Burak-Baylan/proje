import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../base/base_view_model.dart';
import '../../../../extensions/context_extensions.dart';
import '../../../../main.dart';
import '../../../../widgets/loading_alert_dialog.dart';
import '../../login/view/login_view.dart';
import '../../model/user_model.dart';
part 'signup_view_model.g.dart';

class SignupViewModel = _SignupViewModelBase with _$SignupViewModel;

abstract class _SignupViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? contextt;

  @override
  void setContext(BuildContext context) => contextt = context;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String username;
  late String email;
  late String password;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  UserCredential? userCredential;

  Future<void> register() async {
    showLoadingAlertDialog(contextt!);
    setCredential();
    if (!formKey.currentState!.validate()) {
      contextt!.pop;
      return;
    }
    var credentialResponse =
        await firebaseAuthService.signup(email, password, username);
    if (credentialResponse.error != null) {
      contextt!.pop;
      showErrorAlert(credentialResponse.error!.errorMessage!);
      return;
    }
    userCredential = credentialResponse.data;
    var firebaseUserResponse = await firebaseManager.createUser(getUserModel());
    if (!firebaseUserResponse) {
      await firebaseAuthService.deleteUser(userCredential!.user!);
      contextt!.pop;
      showErrorAlert('Bir hatadan ötürü kayıt yapılamadı.');
      return;
    }
    //* SUCCESS ALERT
    contextt!.pop;
    showSuccessAlert();
  }

  UserModel getUserModel() {
    return UserModel(
      userId: userCredential!.user!.uid,
      email: email,
      username: username,
      createdAt: Timestamp.now(),
    );
  }

  void setCredential() {
    username = usernameController.text;
    email = emailController.text;
    password = passwordController.text;
  }

  Future<void> showSuccessAlert() async {
    await showAlert('Başarılı', 'Hesabın başarıyla oluşturuldu.');
    globalVm.replacePage(contextt!, LoginView());
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
