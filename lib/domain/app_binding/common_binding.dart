import 'package:credsafe/screens/homepage/home_controller.dart';
import 'package:credsafe/screens/login/login_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeController());
  }
}