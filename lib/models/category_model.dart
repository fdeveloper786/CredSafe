class CategoryModel {
  final String documentId;
  final String categoryName;
  final String categoryLogo;

  CategoryModel({required this.documentId,required this.categoryName,required this.categoryLogo});

  // Factory constructor to map data from Firestore snapshot
  factory CategoryModel.fromFirestore(Map<String, dynamic> data, String documentId) {
    return CategoryModel(
      documentId: documentId,
      categoryName: data['category_name'] ?? '',
      categoryLogo: data['category_logo'] ?? '',
    );
  }
}