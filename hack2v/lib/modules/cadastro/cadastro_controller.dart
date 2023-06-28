import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../providers/database_user.dart';

class CadastroController extends GetxController {
  var showPassword = true.obs;
  var nomeCompletoController = TextEditingController(text: '');
  var dataNascimentoController = TextEditingController(text: '');
  var userController = TextEditingController(text: '');
  var emailController = TextEditingController(text: '');
  var passwordController = TextEditingController(text: '');

  final db = DataBaseProvider();

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  @override
  void onInit() {
    super.onInit();
    db.initDb().then((value) async {});
  }

  Future<String> cadastro() async {
    try {
      if (nomeCompletoController.text == "" ||
          userController.text == "" ||
          emailController.text == "" ||
          passwordController.text == "") {
        return "Preencha todos os campos";
      }

      var usuario = Usuario(
          nomeCompletoController.text.toString(),
          dataNascimentoController.text.toString(),
          userController.text.toString(),
          emailController.text.toString(),
          passwordController.text.toString());
      await db.insertUsuario(usuario);

      return "ok";
    } catch (e) {
      return "Erro ao cadastrar";
    }
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
