import 'package:credsafe/domain/app_binding/common_binding.dart';
import 'package:credsafe/screens/login/login_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {

  setUp(() {
    Get.reset();
  });

  group('App Binding Tests', () {

    test('AppBinding registers all dependencies', () {
       // Initialize bindings
      AppBinding().dependencies();

      // Verify LoginController is registered and lazy-loaded
      expect(Get.isRegistered<LoginController>(),true);
      final loginController = Get.find<LoginController>();
      expect(loginController,isA<LoginController>());
    });
  });
}