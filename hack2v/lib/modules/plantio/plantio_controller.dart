import 'package:get/get.dart';
import 'package:hack2v/modules/prop_cadastro/prop_cadastro_controller.dart';

import '../../providers/database_prop.dart';
import '../../providers/database_user.dart';
import '../login/login_controller.dart';

class PlantioController extends GetxController{

  PropCadastroController controller = PropCadastroController();

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

  Future<Propriedade?> infos(int id) {
    return db.getFazendaInfo(id);
  }

  void savePropriedade(Propriedade prop) {
    db.updateFazenda(prop);
  }
}