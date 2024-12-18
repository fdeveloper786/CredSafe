import 'package:credsafe/models/category_model.dart';
import 'package:credsafe/services/category_service.dart';
import 'package:credsafe/utils/constants/api_constants.dart';
import 'package:get/get.dart';

class CategoryRepo {
  final CategoryService _categoryService = Get.find();

  /// Fetch data from Firestore
  Future<List<CategoryModel>> fetchData() async {
    try{
      final querySnapshot = await _categoryService.getCollection(CollectionConstants.baseCollection);
      return querySnapshot.docs.map((doc) => CategoryModel.fromFirestore(doc.data(),doc.id)).toList();

    }catch(ex) {
      throw Exception('Failed to fetch data $ex');
    }
  }

  /// Save data into Firestore
  Future<void> insertData(String collectionPath, Map<String,dynamic> data) async {
    try {
      // Adding a document to the specified collection
      await _categoryService.setCollection(collectionPath, data);
    } catch(ex) {
      rethrow;
    }
  }

}