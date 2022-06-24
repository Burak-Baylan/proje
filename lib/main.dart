import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_scroll_behavior.dart';
import 'global/global_view_model.dart';
import 'sayfalar/ana_sayfa/view/ana_sayfa.dart';
import 'widgets/main_page_username_widget.dart';

GlobalViewModel globalVm = GlobalViewModel();

void main() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA4DTyrtKuuIKfVH3CafxaJxYHkQK3Skp0",
      authDomain: "proje-c1d0b.firebaseapp.com",
      projectId: "proje-c1d0b",
      storageBucket: "proje-c1d0b.appspot.com",
      messagingSenderId: "683946021435",
      appId: "1:683946021435:web:168ef2f642af010d71c21e",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Film',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Filmler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: startApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(appBar: buildAppBar(), body: AnaSayfa());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      actions: const [MainPageUsernameWidget()],
      backgroundColor: Color.fromARGB(255, 36, 110, 122),
      title: Text(widget.title),
      centerTitle: true,
      leading: buildLeading(),
    );
  }

  Widget buildLeading() {
    return SizedBox(
      height: kToolbarHeight - 5,
      width: kToolbarHeight - 5,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: const Icon(
          Icons.movie_outlined,
          size: kToolbarHeight - 5,
        ),
      ),
    );
  }

  Future<void> startApp() async {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        globalVm.changeLoggedInState(true);
      }
    });
  }
}
