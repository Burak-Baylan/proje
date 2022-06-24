import 'package:flutter/material.dart';
import '../../../../extensions/context_extensions.dart';
import '../../../../extensions/string_extensions.dart';
import '../../../../main.dart';
import '../../../../widgets/custom_text_from.dart';
import '../../login/view/login_view.dart';
import '../controller/signup_view_model.dart';

class SignupView extends StatefulWidget {
  SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  SignupViewModel signupVm = SignupViewModel();

  @override
  Widget build(BuildContext context) {
    signupVm.setContext(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 110, 122),
        centerTitle: true,
        title: Text('Hesap Oluştur'),
      ),
      backgroundColor: Color.fromARGB(255, 38, 47, 63),
      body: Form(
        key: signupVm.formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTitle,
              const SizedBox(height: 25),
              SizedBox(width: context.width / 3, child: buildUsernameTextField),
              const SizedBox(height: 15),
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
      'Yeni bir hesap oluştur!',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: context.width / 65,
      ),
    );
  }

  Widget get buildUsernameTextField {
    return CustomTextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (text) => text?.usernameValidator,
      labelText: "Kullanıcı Adı",
      icon: Icons.person_outline_rounded,
      controller: signupVm.usernameController,
    );
  }

  Widget get buildEmailTextField {
    return CustomTextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (text) => text?.emailValidator,
      labelText: "E-Posta",
      icon: Icons.email_outlined,
      controller: signupVm.emailController,
    );
  }

  Widget get buildPasswordTextField {
    return CustomTextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (text) => text?.passwordValidator,
      labelText: "Şifre",
      obscureText: true,
      icon: Icons.password_rounded,
      controller: signupVm.passwordController,
    );
  }

  Widget get buildSignupButton {
    return ElevatedButton(
      onPressed: () => signupVm.register(),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0, 50),
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Kayıt Ol',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget get buildLoginButton {
    return ElevatedButton(
      onPressed: () => globalVm.replacePage(context, LoginView()),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0, 50),
        primary: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.white),
        ),
      ),
      child: const Text(
        'Zaten Bir Hesabım Var',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget get buildButtons {
    return Column(
      children: [
        SizedBox(width: context.width / 3, child: buildSignupButton),
        const SizedBox(height: 15),
        SizedBox(width: context.width / 3, child: buildLoginButton),
      ],
    );
  }
}
