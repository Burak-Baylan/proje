import 'package:flutter/material.dart';
import '../../../../extensions/context_extensions.dart';
import '../../../../extensions/string_extensions.dart';
import '../../../../main.dart';
import '../../../../widgets/custom_text_from.dart';
import '../../signup/view/signup_view.dart';
import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewController loginVm = LoginViewController();

  @override
  Widget build(BuildContext context) {
    loginVm.setContext(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild(context));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 110, 122),
        centerTitle: true,
        title: Text('Giriş Yap'),
      ),
      backgroundColor: Color.fromARGB(255, 38, 47, 63),
      body: Form(
        key: loginVm.formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTitle,
              const SizedBox(height: 25),
              SizedBox(width: context.width / 3, child: buildEmailTextField),
              const SizedBox(height: 15),
              SizedBox(width: context.width / 3, child: buildPasswordTextField),
              const SizedBox(height: 25),
              buildButtons,
            ],
          ),
        ),
      ),
    );
  }

  Widget get buildTitle {
    return Text(
      'Hesabına Giriş yap!',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: context.width / 65,
      ),
    );
  }

  Widget get buildEmailTextField {
    return CustomTextFormField(
      keyboardType: TextInputType.emailAddress,
      labelText: "E-Posta",
      icon: Icons.email_outlined,
      validator: (text) => text!.emailValidator,
      controller: loginVm.emailController,
    );
  }

  Widget get buildPasswordTextField {
    return CustomTextFormField(
      keyboardType: TextInputType.emailAddress,
      labelText: "Şifre",
      obscureText: true,
      icon: Icons.password_rounded,
      validator: (text) => text!.passwordValidator,
      controller: loginVm.passwordController,
    );
  }

  Widget get buildButtons {
    return Column(
      children: [
        SizedBox(width: context.width / 3, child: buildLoginButton),
        const SizedBox(height: 15),
        SizedBox(width: context.width / 3, child: buildSignupButton),
      ],
    );
  }

  Widget get buildLoginButton {
    return ElevatedButton(
      onPressed: () => loginVm.login(),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0, 50),
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Giriş Yap',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget get buildSignupButton {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => globalVm.replacePage(context, SignupView()),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(0, 50),
          primary: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white),
          ),
        ),
        child: const Text(
          'Yeni Bir Hesap Oluştur',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> afterBuild(BuildContext context) async {
    if (globalVm.auth.currentUser != null) {
      globalVm.changeLoggedInState(true);
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hoşgeldin ${globalVm.auth.currentUser!.displayName}!'),
            content: Text('Otomatik olarak giriş yapıldı.'),
            actions: [
              TextButton(
                onPressed: () => context.pop,
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
      context.pop;
    }
  }
}
