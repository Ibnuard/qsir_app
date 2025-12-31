import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cashier/controllers/cashier_management_controller.dart';

class CashierManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashierManagementController>(
      () => CashierManagementController(),
    );
  }
}
