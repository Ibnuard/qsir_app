import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cashier/controllers/cashier_login_history_controller.dart';

class CashierLoginHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashierLoginHistoryController>(
      () => CashierLoginHistoryController(),
    );
  }
}
