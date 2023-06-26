import 'package:get/get.dart';

import '../../providers/database_prop.dart';
import '../../providers/database_user.dart';
import '../login/login_controller.dart';

class PropInfoController extends GetxController {
  final db = DataBaseProvider();

  @override
  void onInit() {
    super.onInit();
    db.initDb().then((value) async {});
  }

  LoginController cd = LoginController();
  RxBool isEditing = false.obs;
  void toggleEditing() {
    isEditing.value = !isEditing.value; // Inverte o estado de edição
  }

  Future<List<Propriedade>> props() async {
    List<Propriedade> properties =
        await db.getFazendasPorUsuario((await db.getUserId())!);

    return properties;
  }
}
