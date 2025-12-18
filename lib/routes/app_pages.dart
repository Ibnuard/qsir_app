import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/splash/splash_page.dart';
import 'package:qsir_app/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(name: AppRoutes.initialRoute, page: () => SplashPage()),
  ];
}
