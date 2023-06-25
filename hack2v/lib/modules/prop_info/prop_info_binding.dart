import 'package:get/get.dart';
import 'package:hack2v/modules/prop_info/prop_info_controller.dart';

class Planejamentobinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropInfoController>(() => PropInfoController());
  }
}
