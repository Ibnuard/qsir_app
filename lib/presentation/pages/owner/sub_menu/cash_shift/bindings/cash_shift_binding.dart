import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_shift/controllers/cash_shift_controller.dart';

class CashShiftBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashShiftController>(() => CashShiftController());
  }
}
