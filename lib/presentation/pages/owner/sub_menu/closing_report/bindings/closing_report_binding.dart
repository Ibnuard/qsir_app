import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/owner/sub_menu/closing_report/controllers/closing_report_controller.dart';

class ClosingReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClosingReportController>(() => ClosingReportController());
  }
}
