import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/login/login_page.dart';
import 'package:qsir_app/presentation/pages/owner/main/bindings/owner_main_binding.dart';
import 'package:qsir_app/presentation/pages/owner/main/main_page.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_shift/bindings/cash_shift_binding.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_shift/cash_shift_page.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_history/bindings/cash_history_binding.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_history/cash_history_page.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/product/add/owner_product_add_page.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/product/detail/owner_product_detail_page.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/bindings/cash_diff_binding.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/bindings/cash_diff_history_binding.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/cash_diff_history_page.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/cash_diff_page.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/closing_report/bindings/closing_report_binding.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/closing_report/closing_report_page.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/product/productlist/owner_product_list_page.dart';
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
    GetPage(name: AppRoutes.ownerProductAdd, page: () => OwnerProductAddPage()),
    GetPage(
      name: AppRoutes.ownerProductDetail,
      page: () => OwnerProductDetailPage(),
    ),
    GetPage(
      name: AppRoutes.ownerCashShift,
      page: () => const CashShiftPage(),
      binding: CashShiftBinding(),
    ),
    GetPage(
      name: AppRoutes.ownerCashHistory,
      page: () => const CashHistoryPage(),
      binding: CashHistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.ownerCashDiff,
      page: () => const CashDiffPage(),
      binding: CashDiffBinding(),
    ),
    GetPage(
      name: AppRoutes.ownerCashDiffHistory,
      page: () => const CashDiffHistoryPage(),
      binding: CashDiffHistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.ownerClosingReport,
      page: () => const ClosingReportPage(),
      binding: ClosingReportBinding(),
    ),
  ];
}
