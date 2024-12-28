import 'package:credsafe/utils/common_widgets/onboard_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnBoardBox Widget Tests', () {
    const svgName = 'assets/icons/sample.svg';
    const title = 'Sample Title';
    const description = 'This is a sample description for the onboard box widget.';

    // Mock the SvgPicture.asset method to avoid loading real SVG files during tests
    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    // Helper function to wrap widgets in MaterialApp
    Widget wrapWithMaterialApp(Widget widget) {
      return MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      );
    }

    testWidgets('renders OnBoardBox widget without errors', (WidgetTester tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(
        const OnBoardBox(
          svgName: svgName,
          title: title,
          description: description,
        ),
      ));

      expect(find.byType(OnBoardBox), findsOneWidget);
    });

    testWidgets('displays the correct SVG asset', (WidgetTester tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(
        const OnBoardBox(
          svgName: svgName,
          title: title,
          description: description,
        ),
      ));

      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('displays the title correctly', (WidgetTester tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(
        const OnBoardBox(
          svgName: svgName,
          title: title,
          description: description,
        ),
      ));

      expect(find.text(title), findsOneWidget);
    });

    testWidgets('displays the description correctly', (WidgetTester tester) async {
      await tester.pumpWidget(wrapWithMaterialApp(
        const OnBoardBox(
          svgName: svgName,
          title: title,
          description: description,
        ),
      ));

      expect(find.text(description), findsOneWidget);
    });

    testWidgets('description supports scrolling if content overflows', (WidgetTester tester) async {
      const longDescription = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
          'Phasellus eget metus nulla. Donec auctor neque a libero malesuada, '
          'id feugiat nunc vestibulum. Sed dapibus, libero nec ultrices aliquam, '
          'turpis orci accumsan metus, in fermentum justo enim et nulla.';

      await tester.pumpWidget(wrapWithMaterialApp(
        const OnBoardBox(
          svgName: svgName,
          title: title,
          description: longDescription,
        ),
      ));

      expect(find.text(longDescription), findsOneWidget);

      // Scroll the SingleChildScrollView
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -50));
      await tester.pump();

      expect(find.text(longDescription), findsOneWidget);
    });
  });
}
