import 'package:get/get.dart';
import 'package:hack2v/modules/perdas/perda_controller.dart';

class PerdaBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PerdaController>(() => PerdaController());
  }

}