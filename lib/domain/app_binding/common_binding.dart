import 'package:credsafe/screens/dashboard/dashboard_controller.dart';
import 'package:credsafe/screens/login/login_controller.dart';
import 'package:credsafe/services/category_service.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => CategoryService());
  }
}