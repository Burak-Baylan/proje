import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'global_view_model.g.dart';

class GlobalViewModel = _GlobalViewModelBase with _$GlobalViewModel;

abstract class _GlobalViewModelBase with Store {
  @observable
  bool isLoggedIn = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  User? get currentUser => auth.currentUser;

  @action
  void changeLoggedInState(bool state) => isLoggedIn = state;

  void sendToPage(BuildContext context, Widget page) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));

  void replacePage(BuildContext context, Widget page) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => page));
}
