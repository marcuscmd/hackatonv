import 'package:get/get.dart';

import '../register_login/registro_controller.dart';
import 'controller_login.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
     Get.lazyPut<LoginCadastroController>(() => LoginCadastroController());
  }

}