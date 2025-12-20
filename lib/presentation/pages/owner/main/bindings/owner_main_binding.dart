import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/owner/home/controllers/home_controller.dart';
import 'package:qsir_app/presentation/pages/owner/main/controllers/owner_main_controller.dart';

class OwnerMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerMainController>(() => OwnerMainController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
