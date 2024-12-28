import 'package:credsafe/utils/common_widgets/button.dart';
import 'package:credsafe/utils/sizes/size.dart';
import 'package:custom_gradient_button/custom_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  testWidgets('AppButton displays the correct label and triggers onTap', (WidgetTester tester) async {
    // Arrange: Define test data
    const String buttonText = 'Click Me';
    bool onTapCalled = false;  // Variable to track if the onTap method is called

    // Define the onTap method
    void onTap() {
      onTapCalled = true;
    }

    // Act: Build the AppButton widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            btnLabel: buttonText,
            onTap: onTap,
            firstColor: Colors.red,
            secondColor: Colors.blue,
            height: 60.0,
            width: 200.0,
          ),
        ),
      ),
    );

    // Assert: Verify that the button label is displayed correctly
    expect(find.text(buttonText), findsOneWidget);

    // Assert: Verify the button's default size and color
    final CustomGradientButton button = tester.widget(find.byType(CustomGradientButton));
    expect(button.firstColor, Colors.red);  // Check if the first color is red
    expect(button.secondColor, Colors.blue);  // Check if the second color is blue
    expect(button.height, 60.0);  // Check if the height is 60
    expect(button.width, 200.0);  // Check if the width is 200

    // Act: Tap on the button
    await tester.tap(find.byType(CustomGradientButton));
    await tester.pump();  // Rebuild the widget tree

    // Assert: Check if onTap was called
    expect(onTapCalled, true);
  });

  testWidgets('AppButton uses default values when no values are provided', (WidgetTester tester) async {
    // Arrange: Define a default button label
    const String defaultButtonText = '';

    // Act: Build the AppButton widget with default values
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(),
        ),
      ),
    );

    // Assert: Verify that the default label (empty string) is displayed
    expect(find.text(defaultButtonText), findsOneWidget);

    // Assert: Verify the button's default size and color
    final CustomGradientButton button = tester.widget(find.byType(CustomGradientButton));
    expect(button.firstColor, Colors.greenAccent);  // Default first color
    expect(button.secondColor, Colors.blueAccent);  // Default second color
    expect(button.height, h50);  // Default height
    expect(button.width, w250);  // Default width
  });
}