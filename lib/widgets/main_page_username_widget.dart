import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';
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
  String projectLink = 'https://github.com/Burak-Baylan/proje';

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Row(
        children: [
          globalVm.isLoggedIn ? usernameWidget() : loginOrSignupWidget(),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () => launchUrl(Uri.parse(projectLink)),
            icon: const Icon(Icons.device_unknown),
          ),
          const SizedBox(width: 10),
        ],
      );
    });
  }

  Widget usernameWidget() {
    var user = globalVm.auth.currentUser!;
    return InkWell(
      onTap: () => globalVm.sendToPage(context, ProfileView()),
      child: Row(
        children: [
          const Icon(Icons.account_circle),
          const SizedBox(width: 5),
          Text(user.displayName!),
          const SizedBox(width: 10),
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
            children: const [
              Icon(Icons.login),
              SizedBox(width: 5),
              Text('Login'),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text('or'),
        const SizedBox(width: 10),
        InkWell(
          onTap: () => globalVm.sendToPage(context, SignupView()),
          child: Row(
            children: const [
              Icon(Icons.person_add),
              SizedBox(width: 5),
              Text('Signup'),
            ],
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
