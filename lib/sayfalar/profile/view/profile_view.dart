import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../extensions/context_extensions.dart';
import '../../../main.dart';
import '../../my_tickets/view/my_tickets_view.dart';
import '../controller/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User? currentUser;

  ProfileController profileVm = ProfileController();

  String projectLink = 'https://github.com/Burak-Baylan/proje';

  @override
  Widget build(BuildContext context) {
    profileVm.setContext(context);
    currentUser = globalVm.auth.currentUser!;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 47, 63),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 110, 122),
        centerTitle: true,
        title: const Text('Profil'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildUsernameWidget,
              const SizedBox(height: 15),
              buildEmailWidget,
              const SizedBox(height: 25),
              buildMyTicketsButton,
              const SizedBox(height: 25),
              buildForgotPasswordButton,
              const SizedBox(height: 25),
              howToUseButton,
              const SizedBox(height: 25),
              buildLogoutButton,
            ],
          ),
        ),
      ),
    );
  }

  Widget get buildUsernameWidget {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        getText(
          text: 'Kullanıcı Adı: ',
          isBold: true,
          fontSize: context.width / 58,
        ),
        getText(
          text: currentUser!.displayName!,
          fontSize: context.width / 58,
        ),
      ],
    );
  }

  Widget get buildEmailWidget {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        getText(
          text: 'E-Posta: ',
          isBold: true,
          fontSize: context.width / 58,
        ),
        getText(
          text: currentUser!.email!,
          fontSize: context.width / 58,
        ),
      ],
    );
  }

  Widget get buildMyTicketsButton {
    return SizedBox(
      width: context.width / 3,
      child: ElevatedButton(
        onPressed: () => globalVm.sendToPage(context, MyTicketsView()),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(0, 50),
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: getText(
          text: 'Biletlerim',
          blackText: true,
        ),
      ),
    );
  }

  Widget get buildForgotPasswordButton {
    return SizedBox(
      width: context.width / 3,
      child: ElevatedButton(
        onPressed: () => profileVm.sendPasswordResetEmail(),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(0, 50),
          primary: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        child: getText(text: 'Şifremi Unuttum'),
      ),
    );
  }

  Widget get howToUseButton {
    return SizedBox(
      width: context.width / 3,
      child: ElevatedButton(
        onPressed: () => launchUrl(Uri.parse(projectLink)),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(0, 50),
          primary: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.green.shade400, width: 2),
          ),
        ),
        child: getText(text: 'Nasıl Kullanılır'),
      ),
    );
  }

  Widget get buildLogoutButton {
    return SizedBox(
      width: context.width / 3,
      child: ElevatedButton(
        onPressed: () => profileVm.logoutAlert(),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(0, 50),
          primary: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.redAccent, width: 2),
          ),
        ),
        child: getText(text: 'Hesaptan Çıkış Yap'),
      ),
    );
  }

  Text getText({
    required String text,
    double? fontSize,
    bool isBold = false,
    bool isExpanded = false,
    bool blackText = false,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? context.width / 90,
        fontWeight: isBold ? FontWeight.bold : FontWeight.bold,
        color: blackText ? Colors.black : Colors.white,
      ),
    );
  }
}
