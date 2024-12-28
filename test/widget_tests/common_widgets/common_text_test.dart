import 'package:credsafe/utils/common_widgets/common_text.dart';
import 'package:credsafe/utils/constants/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('Common Text Widget',() {

    testWidgets('CommonText uses default text style and alignment when not provided', (WidgetTester tester) async {
      // Arrange
      const text = 'Hello, world';

      // Act: Pump the CommonText widget into the widget tree without providing any style or alignment
      await tester.pumpWidget(
       const  MaterialApp(
          home: Scaffold(
            body: CommonText(text: text,),
          )
        )
      );

      // Assert:
      // Verify that the text is displayed with default style and alignment
      final textWidget = find.byType(Text);
      expect(textWidget,findsOneWidget);

      final textWidgetFinder = tester.firstWidget<Text>(textWidget);

      // Check if the text is correct
      expect(textWidgetFinder.data,equals(text));

      // Check the default style (should match AppStyle.textBlack20, so verify color and font size)
      expect(textWidgetFinder.style,equals(AppStyle.txtBlack20));

      // Check the default alignment (should be TextAlign.left)
      expect(textWidgetFinder.textAlign,equals(TextAlign.left));
    });

    testWidgets('CommonText applies custom text style correctly', (WidgetTester tester) async {
      // Arrange
      const text = 'Custom Styled Text';
      const customStyle = TextStyle(fontSize: 24,color: Colors.blue);

      // Act: Pump the CommonText widget with a custom text style
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CommonText(text: text,textStyle: customStyle,),
          ),
        )
      );

      // Assert: Verify that the text is displayed with the custom style
      final textWidget = find.byType(Text);
      expect(textWidget,findsOneWidget);

      final textWidgetFinder = tester.firstWidget<Text>(textWidget);

      // Check if the text is correct
      expect(textWidgetFinder.data,equals(text));

      // Check if the custom style is applied
      expect(textWidgetFinder.style,equals(customStyle));
    });

    testWidgets('CommonText applies custom text alignment correctly', (WidgetTester tester) async {
      // Arrange
      const text = 'Centered Text';

      // Act: Pump the CommonText widget with custom text alignment
      await tester.pumpWidget(
       const MaterialApp(
          home: Scaffold(
            body: CommonText(text: text,textAlign: TextAlign.center,),
          ),
        )
      );

      // Assert: Verify that the text is aligned as per the custom alignment
      final textWidget = find.byType(Text);
      expect(textWidget,findsOneWidget);

      final textWidgetFinder = tester.firstWidget<Text>(textWidget);

      // Check if the text is correct
      expect(textWidgetFinder.data,equals(text));

      // Check if the alignment is custom (TextAlign.center)
      expect(textWidgetFinder.textAlign,equals(TextAlign.center));
    });

  });

}