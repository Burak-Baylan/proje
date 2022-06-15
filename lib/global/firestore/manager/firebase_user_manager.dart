import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserManager {
  static FirebaseUserManager? _instance;
  static FirebaseUserManager get instance =>
      _instance = _instance == null ? FirebaseUserManager._init() : _instance!;
  FirebaseUserManager._init();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
}
