import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../global/firestore/auth/service/firebase_auth_service.dart';
import '../global/firestore/manager/firebase_manager.dart';
import '../global/firestore/service/firebase_service.dart';

abstract class BaseViewModel {
  BuildContext? contextt;
  void setContext(BuildContext context);

  Timestamp get currentTime => Timestamp.now();

  FirebaseAuthService authService = FirebaseAuthService.instance;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseManager firebaseManager = FirebaseManager.instance;
  FirebaseAuthService firebaseAuthService = FirebaseAuthService.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirestoreService firestoreService = FirestoreService.instance;
}
