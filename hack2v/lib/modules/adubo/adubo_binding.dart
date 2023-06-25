import 'package:get/get.dart';
import 'adubo_controller.dart';

class AduboBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AduboController>(() => AduboController());
  }
}
