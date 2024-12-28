import 'package:credsafe/main.dart';
import 'package:credsafe/screens/auth_wrapper/auth_wrapper.dart';
import 'package:credsafe/screens/onboard/onboard_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({
      'isFirstTime': true, // Mock the value for 'isFirstTime'
    });
  });

  testWidgets('MyApp shows OnboardingScreen when isFirstTime is true', (WidgetTester tester) async {
    // Act: Pump the MyApp widget with isFirstTime set to true
    await tester.pumpWidget(const MyApp(isFirstTime: true));
    await tester.pumpAndSettle();

    // Assert: Check if OnboardingScreen is found
    expect(find.byType(OnboardingScreen), findsOneWidget);  // Look for the OnboardingScreen widget type

    // Optionally: Check if AuthWrapper is not found
    expect(find.byType(AuthWrapper), findsNothing);  // Check if AuthWrapper is not in the widget tree
  });

  testWidgets('MyApp shows AuthWrapper when isFirstTime is false', (WidgetTester tester) async {
    // Act: Pump the MyApp widget with isFirstTime set to false
    await tester.pumpWidget(const MyApp(isFirstTime: false));
    await tester.pumpAndSettle();

    // Assert: Check if AuthWrapper is found
    expect(find.byType(AuthWrapper), findsOneWidget);  // Look for the AuthWrapper widget type

    // Optionally: Check if OnboardingScreen is not found
    expect(find.byType(OnboardingScreen), findsNothing);  // Check if OnboardingScreen is not in the widget tree
  });
}