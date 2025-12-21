import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/login/login_page.dart';
import 'package:qsir_app/presentation/pages/owner/main/bindings/owner_main_binding.dart';
import 'package:qsir_app/presentation/pages/owner/main/main_page.dart';
import 'package:qsir_app/presentation/pages/owner/product/productlist/owner_product_list_page.dart';
import 'package:qsir_app/presentation/pages/splash/splash_page.dart';
import 'package:qsir_app/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(name: AppRoutes.initialRoute, page: () => SplashPage()),
    GetPage(name: AppRoutes.login, page: () => LoginPage()),

    // Owner
    GetPage(
      name: AppRoutes.ownerMain,
      page: () => OwnerMainPage(),
      binding: OwnerMainBinding(),
    ),
    GetPage(
      name: AppRoutes.ownerProductList,
      page: () => OwnerProductListPage(),
    ),
  ];
}
