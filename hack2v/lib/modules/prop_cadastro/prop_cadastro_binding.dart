import 'package:get/get.dart';
import 'package:hack2v/modules/prop_cadastro/prop_cadastro_controller.dart';

class PropCadastroBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PropCadastroController>(() => PropCadastroController());
  }

}