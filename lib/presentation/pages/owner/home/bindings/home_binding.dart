import 'package:get/get.dart';
import 'package:qsir_app/presentation/pages/owner/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
