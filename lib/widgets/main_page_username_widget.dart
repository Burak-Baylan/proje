import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../main.dart';
import '../sayfalar/authenticate/login/view/login_view.dart';
import '../sayfalar/authenticate/signup/view/signup_view.dart';
import '../sayfalar/profile/view/profile_view.dart';

class MainPageUsernameWidget extends StatefulWidget {
  const MainPageUsernameWidget({Key? key}) : super(key: key);

  @override
  State<MainPageUsernameWidget> createState() => _MainPageUsernameWidgetState();
}

class _MainPageUsernameWidgetState extends State<MainPageUsernameWidget> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return globalVm.isLoggedIn ? usernameWidget() : loginOrSignupWidget();
    });
  }

  Widget usernameWidget() {
    var user = globalVm.auth.currentUser!;
    return InkWell(
      onTap: () => globalVm.sendToPage(context, ProfileView()),
      child: Row(
        children: [
          Icon(Icons.account_circle),
          SizedBox(width: 5),
          Text(user.displayName!),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget loginOrSignupWidget() {
    return Row(
      children: [
        InkWell(
          onTap: () => globalVm.sendToPage(context, LoginView()),
          child: Row(
            children: [
              Icon(Icons.login),
              SizedBox(width: 5),
              Text('Login'),
            ],
          ),
        ),
        SizedBox(width: 10),
        Text('or'),
        SizedBox(width: 10),
        InkWell(
          onTap: () => globalVm.sendToPage(context, SignupView()),
          child: Row(
            children: [
              Icon(Icons.person_add),
              SizedBox(width: 5),
              Text('Signup'),
            ],
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
