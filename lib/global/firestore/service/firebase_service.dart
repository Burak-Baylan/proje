import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/custom_data.dart';
import '../../error/custom_error.dart';

class FirestoreService {
  static FirestoreService? _instance;
  static FirestoreService get instance =>
      _instance = _instance == null ? FirestoreService._init() : _instance!;
  FirestoreService._init();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future updateValue(
    int value,
    DocumentReference documentReference,
    String fieldName,
  ) async {
    var increment = _increaser(value);
    WriteBatch batch = firestore.batch();
    batch.update(documentReference, {fieldName: increment});
    await batch.commit();
  }

  FieldValue _increaser(int value) => FieldValue.increment(value);

  CustomData<E> getAField<E>(
    DocumentSnapshot<Object?> path,
    String fieldName,
  ) {
    try {
      var data = path.get(fieldName);
      return CustomData<E>(data, null);
    } catch (e) {
      return CustomData<E>(null, CustomError(e.toString()));
    }
  }

  Future<CustomError> deleteDocument(DocumentReference reference) async {
    try {
      await reference.delete();
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<CustomError> addDocument(
    DocumentReference reference,
    Object? data,
  ) async {
    try {
      await reference.set(data);
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<CustomError> updateDocument(
      DocumentReference reference, Map<String, Object?> data) async {
    try {
      await reference.update(data);
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<CustomData<QuerySnapshot<Map<String, dynamic>>>> getCollection(
      CollectionReference<Map<String, dynamic>> collectionRef) async {
    try {
      var data = await collectionRef.get();
      return CustomData(data, null);
    } on FirebaseException catch (e) {
      return CustomData(null, CustomError(e.message));
    }
  }

  Future<CustomData<DocumentSnapshot<Object?>>> getDocument(
      DocumentReference reference) async {
    try {
      var data = await reference.get();
      return CustomData(data, null);
    } on FirebaseException catch (e) {
      return CustomData(null, CustomError(e.message));
    }
  }

  Future<CustomData<QuerySnapshot<Map<String, dynamic>>>> getQuery(
      Query<Map<String, dynamic>> query) async {
    try {
      var data = await query.get();
      return CustomData(data, null);
    } on FirebaseException catch (e) {
      return CustomData(null, CustomError(e.message));
    }
  }
}
