import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    toast("Cadastrado com Sucesso!");
    Get.toNamed('/menu');

    return "ok";
  }

  Future<bool?> toast(String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: const Color.fromARGB(255, 32, 82, 77),
        textColor: Colors.white,
        fontSize: 15.0);
  }
}
