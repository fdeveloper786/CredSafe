import 'dart:convert';
import 'package:credsafe/utils/common_widgets/categories_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Create a mock class for AssetBundle
class MockAssetBundle extends Mock implements AssetBundle {}

void main() {
  // Ensure the flutter test bindings are initialized.
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CategoryItemsScreen Widget Test', () {
    testWidgets('shows CircularProgressIndicator while loading', (WidgetTester tester) async {
      // Create a mock instance of AssetBundle
      final mockBundle = MockAssetBundle();

      // Mock the loadString method to return a Future with mock data
      when(mockBundle.loadString('assets/json/categories_data.json'))
          .thenAnswer((_) async => '{"categoryItems": { "Social Media": [{"title": "Facebook","icon": "assets/svg/social_media/facebook.svg"}]}}');

      // Convert the mocked response to ByteData
      final byteData = ByteData.sublistView(Uint8List.fromList(utf8.encode('{"categoryItems": { "Social Media": [{"title": "Facebook","icon": "assets/svg/social_media/facebook.svg"}]}')));

      // Replace the rootBundle's load method to use the mocked loadString
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'flutter/assets',
      (message) async => byteData,
      );

      // Setup the test widget with MaterialApp
      await tester.pumpWidget(const MaterialApp(
      home: CategoryItemsScreen('Social Media'),
      ));

      // Verify if CircularProgressIndicator is displayed while loading
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Allow the widget to settle after async operations
      await tester.pumpAndSettle();
    });
  });
}