import 'package:credsafe/screens/dashboard/dashboard_binding.dart';
import 'package:credsafe/screens/dashboard/dashboard_screen.dart';
import 'package:credsafe/screens/login/login.dart';
import 'package:credsafe/screens/login/login_binding.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String initialRoute = "/initialRoute";

  static const String loginScreen = "/login";

  static const String homeScreen = "/home_screen";



  static List<GetPage> pages = [
    GetPage(name: loginScreen, page:() => Login(), bindings: [ LoginBinding() ]),
    GetPage(name: initialRoute, page:() => Login(), bindings: [ LoginBinding() ]),
    GetPage(name: homeScreen, page:() =>  Dashboard(), bindings: [ DashboardBinding() ]),
  ];
}