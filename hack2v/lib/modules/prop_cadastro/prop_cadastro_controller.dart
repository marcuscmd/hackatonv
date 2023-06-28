import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hack2v/providers/database_prop.dart';
import 'package:intl/intl.dart';

import '../../providers/database_user.dart';
import '../login/login_controller.dart';

class PropCadastroController extends GetxController {
  LoginController cd = LoginController();
  var nomePropController = TextEditingController(text: '');
  var hectarController = TextEditingController(text: '');
  var dataController = TextEditingController(text: '');
  var tipoController = 'Tipo do Plantio';

  final db = DataBaseProvider();

  @override
  void onInit() {
    super.onInit();
    db.initDb().then((value) async {});
  }

  Future<String> cadastro() async {
    var prop = Propriedade(
      id: 0,
      nomePropriedade: nomePropController.text,
      hectar: double.parse(hectarController.text),
      data: dataController.text.toString(),
      tipo: tipoController,
      idUsuario: int.parse((await db.getUserId()).toString()),
    );
    await db.insertFazenda(prop);
    Get.toNamed('/menu');

    return "ok";
  }
}
