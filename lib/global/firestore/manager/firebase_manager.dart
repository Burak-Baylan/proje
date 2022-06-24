import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../sayfalar/authenticate/model/user_model.dart';
import '../../error/custom_error.dart';
import '../service/firebase_service.dart';

class FirebaseManager {
  static FirebaseManager? _instance;
  static FirebaseManager get instance =>
      _instance = _instance == null ? FirebaseManager._init() : _instance!;
  FirebaseManager._init();

  FirestoreService firebaseService = FirestoreService.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> createUser(UserModel userModel) async {
    var ref = firestore.collection('users').doc(userModel.userId);
    var response = await firebaseService.addDocument(ref, userModel.toJson());
    if (response.errorMessage != null) {
      return false;
    }
    return true;
  }

  Future<Map<String, dynamic>?> getADocument(
    DocumentReference<Object?> reference,
  ) async {
    var rawData = await firebaseService.getDocument(reference);
    if (rawData.error != null || rawData.data?.data() == null) return null;
    var data = rawData.data!.data() as Map<String, dynamic>;
    return data;
  }

  Future<CustomError> update(
          DocumentReference ref, Map<String, dynamic> data) async =>
      await firebaseService.updateDocument(ref, data);
}
