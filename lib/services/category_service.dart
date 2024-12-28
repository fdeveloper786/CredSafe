import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryService extends GetxService {
  final FirebaseFirestore _firebaseFirestore;

  // Constructor with dependency injection
  CategoryService({FirebaseFirestore? firebaseFirestore}) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getCollection(String collectionPath) {
    return _firebaseFirestore.collection(collectionPath).get();
  }

  Future<void> setCollection(String collectionPath, Map<String, dynamic> data) async {
    try {
      await _firebaseFirestore.collection(collectionPath).add(data);
    } catch (ex) {
      rethrow;
    }
  }
}