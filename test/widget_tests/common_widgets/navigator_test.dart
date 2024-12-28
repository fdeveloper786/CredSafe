import 'package:credsafe/utils/common_widgets/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


// Define a simple TestScreen to navigate to
class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Screen')),
      body: const Center(child: Text('Test Screen')),
    );
  }
}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });


  testWidgets('AppNavigator correctly navigates to TestScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ElevatedButton(
            onPressed: (){
              AppNavigator.commonNavigator(tester.element(find.byType(ElevatedButton)), const TestScreen());
            },
            child: const Text('Navigate'),
          ),
        ),
      )
    );

    expect(find.text('Navigate'),findsOneWidget);

    // Simulate a tap on the 'Navigate' button
    await tester.tap(find.text('Navigate'));
    await tester.pumpAndSettle();

    expect(find.byType(TestScreen),findsOneWidget);
  });
}