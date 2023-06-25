import 'package:get/get.dart';
import 'package:hack2v/modules/cadastro/cadastro_controller.dart';

class CadastroBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CadastroController>(() => CadastroController());
  }

}