import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_diff/controllers/cash_diff_controller.dart';

class CashDiffBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashDiffController>(() => CashDiffController());
  }
}
