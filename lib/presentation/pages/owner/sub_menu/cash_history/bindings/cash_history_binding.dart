import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/cash_history/controllers/cash_history_controller.dart';

class CashHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashHistoryController>(() => CashHistoryController());
  }
}
