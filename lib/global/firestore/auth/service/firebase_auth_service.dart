import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/custom_data.dart';
import '../../../error/custom_error.dart';

class FirebaseAuthService {
  static FirebaseAuthService? _instance;
  static FirebaseAuthService get instance =>
      _instance = _instance == null ? FirebaseAuthService._init() : _instance!;
  FirebaseAuthService._init();

  FirebaseAuth auth = FirebaseAuth.instance;

  User? get currentUser => auth.currentUser;

  Future<CustomData<UserCredential>> login(
    String email,
    String password,
  ) async {
    try {
      UserCredential? userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return CustomData<UserCredential>(userCredential, null);
    } on FirebaseException catch (e) {
      return CustomData<UserCredential>(null, CustomError(e.message));
    }
  }

  Future<CustomData<UserCredential>> signup(
    String email,
    String password,
    String username,
  ) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(username);
      return CustomData<UserCredential>(userCredential, null);
    } on FirebaseException catch (e) {
      return CustomData<UserCredential>(null, CustomError(e.message));
    }
  }

  Future<CustomError> deleteUser(User user) async {
    try {
      await user.delete();
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<CustomError> sendPasswordResetEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<void> sendVerificationEmail() async =>
      await currentUser?.sendEmailVerification();
}
