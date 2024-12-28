import 'package:credsafe/domain/app_routes/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppRoutes Tests Cases', () {

    test('Verify all routes are defined and valid', () {
      expect(AppRoutes.pages.isNotEmpty,true,reason: 'AppRoutes.pages should not be empty');

      for(final route in AppRoutes.pages) {
        expect(route.name.isNotEmpty,true,reason: 'Route name should not be empty');
        expect(route.page is Function,true,reason: 'Route should have a valid page builder function');
        expect(route.bindings.isNotEmpty,true,reason: 'Route should have a bindings defined.');
      }
    });

    test('Route names are correctly defined', () {
      expect(AppRoutes.initialRoute,'/initialRoute');

      expect(AppRoutes.loginScreen,'/login');

      expect(AppRoutes.homeScreen,'/home_screen');
    });

  });
}