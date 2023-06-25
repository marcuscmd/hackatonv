import 'package:get/get.dart';
import 'package:hack2v/modules/plantio/plantio_controller.dart';

class PlantioBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PlantioController>(() => PlantioController());
  }

}