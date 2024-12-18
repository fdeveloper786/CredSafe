import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:credsafe/models/category_model.dart';
import 'package:credsafe/repository/category_repo.dart';
import 'package:credsafe/services/internet_service.dart';
import 'package:credsafe/utils/constants/api_constants.dart';
import 'package:credsafe/utils/constants/json_constants.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final internetService = InternetService();
  // Observable variable to store the categories data
  final CategoryRepo _categoryRepo = CategoryRepo();

  // Observable data list
  var categories = <CategoryModel>[].obs;

  String categoryName = '';

  @override
  void onInit() {
    super.onInit();
    getCategoriesData();
  }

  /// Method to fetch categories from Firebase
  Future<void> getCategoriesData() async {
    try{
      internetService.initialize();  // Start listening to connectivity changes

    // Listen to the stream for connectivity updates
      internetService.connectivityStream.listen((isConnected) async {
        if (isConnected) {
          log('Internet is connected');
          final data = await _categoryRepo.fetchData();
          log('data is ${data.length}');
          categories.assignAll(data);
        } else {
          log('Internet is disconnected');
          await loadCategoriesFromLocal();
        }
      });
    }catch(ex) {
      rethrow;
    }
  }
  // Method to load categories from the JSON file
  Future<void> loadCategoriesFromLocal() async {
    try {
      // Load the JSON file from the assets folder
      String jsonString = await rootBundle.loadString(jsonCategoriesData);

      // Decode the JSON string into a Map
      var data = jsonDecode(jsonString);

      // Extract the 'categories' list from the decoded JSON data and cast each element to Map<String, String>
      List<CategoryModel> loadedCategories = List<CategoryModel>.from(data['categories'].map((category) {
            return CategoryModel(
                documentId: category['documentId'].toString(),
                categoryName: category['category_name'],
                categoryLogo: category['category_logo']
            );
          })
      );
      // Update the categories observable list with the loaded categories
      categories.assignAll(loadedCategories);
    } catch (e) {
      // Handle any errors that occur while loading the data
      log("Error loading categories: $e");
    }
  }

  /// Method to insert data
  Future<void> insertData(String collectionPath,Map<String,dynamic> categoryData) async  {
    try
    {
      _categoryRepo.insertData(collectionPath, categoryData);
    }
    catch(ex) {
      rethrow;
    }
  }

  String getCollectionName(String categoryName) {
    switch(categoryName) {
      case "Social Media":
        categoryName = CollectionConstants.socialMediaCollection;
        break;
      case "Banking":
        categoryName = CollectionConstants.bankingCollection;
        break;
      case "Google":
        categoryName = CollectionConstants.googleCollection;
        break;
      case "Control Version":
        categoryName = CollectionConstants.controlCollection;
        break;
      case "Entertainment":
        categoryName = CollectionConstants.entertainmentCollection;
        break;
      case "Microsoft":
        categoryName = CollectionConstants.microsoftCollection;
        break;
    }
    return categoryName;
  }
}