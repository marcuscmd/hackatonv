import 'package:get/get.dart';

import 'prop_cadastro_controller.dart';

class PropCadastroBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropCadastroController>(() => PropCadastroController());
  }
}
