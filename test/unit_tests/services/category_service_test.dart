import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credsafe/services/category_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'category_service_test.mocks.dart';

/// Mock FirebaseFirestore and its dependencies
/*
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference<Map<String,dynamic>> {}

class MockDocumentReference extends Mock implements DocumentReference<Map<String,dynamic>> {}

class MockQuerySnapshot extends Mock implements QuerySnapshot<Map<String,dynamic>> {}

*/
@GenerateMocks([
  FirebaseFirestore,
  CollectionReference<Map<String, dynamic>>,
  QuerySnapshot<Map<String, dynamic>>,
])
void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollection;
  late MockQuerySnapshot<Map<String, dynamic>> mockSnapshot;
  late CategoryService categoryService;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference<Map<String, dynamic>>();
    mockSnapshot = MockQuerySnapshot<Map<String, dynamic>>();
    categoryService = CategoryService(firebaseFirestore: mockFirestore);
  });

  group('category service', () {

    test('should fetch a collection from Firestore', () async {
      // Arrange
      const collectionPath = 'testCollection';
      when(mockFirestore.collection(collectionPath)).thenReturn(mockCollection);
      when(mockCollection.get()).thenAnswer((_) async => mockSnapshot);

      // Act
      final result = await categoryService.getCollection(collectionPath);

      // Assert
      expect(result, equals(mockSnapshot));
      verify(mockFirestore.collection(collectionPath)).called(1);
      verify(mockCollection.get()).called(1);
    });

    test('should throw an exception when fetching a collection fails', () async {
      // Arrange
      const collectionPath = 'testCollection';
      final exception = Exception('Error fetching collection');
      when(mockFirestore.collection(collectionPath)).thenReturn(mockCollection);
      when(mockCollection.get()).thenThrow(exception);

      // Act & Assert
      expect(
            () => categoryService.getCollection(collectionPath),
        throwsA(isA<Exception>()),
      );

      verify(mockFirestore.collection(collectionPath)).called(1);
      verify(mockCollection.get()).called(1);
    });

    test('should throw an exception when fetching a collection fails', () async {
      // Arrange
      const collectionPath = 'testCollection';
      final exception = Exception('Error fetching collection');
      when(mockFirestore.collection(collectionPath)).thenReturn(mockCollection);
      when(mockCollection.get()).thenThrow(exception);

      // Act & Assert
      expect(
            () => categoryService.getCollection(collectionPath),
        throwsA(isA<Exception>()),
      );

      verify(mockFirestore.collection(collectionPath)).called(1);
      verify(mockCollection.get()).called(1);
    });

    test('should throw an exception when inserting data fails', () async {
      // Arrange
      const collectionPath = 'testCollection';
      const testData = {'key' : 'value'};
      final exception = Exception('Error adding data');

      when(mockFirestore.collection(collectionPath)).thenReturn(mockCollection);
      when(mockCollection.add(testData)).thenThrow(exception);

      // Act & Assert
      expect(
            () => categoryService.setCollection(collectionPath, testData),
        throwsA(isA<Exception>()),
      );
      verify(mockFirestore.collection(collectionPath)).called(1);
      verify(mockCollection.add(testData)).called(1);
    });
  });
}