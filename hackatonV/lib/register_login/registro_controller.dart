import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hackaton/models/graos_db.dart';

import '../models/banco.dart';

class LoginCadastroController extends GetxController {
  var showPassword = true.obs;
  var nomeCompletoController = TextEditingController(text: '');
  var dataNascimentoController = TextEditingController(text: '');
  var userController = TextEditingController(text: '');
  var emailController = TextEditingController(text: '');
  var passwordController = TextEditingController(text: '');

  final db = Graos();

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  @override
  void onInit() {
    super.onInit();
    db.connect().then((value) async {});
  }

  Future<String> cadastro() async {
    try {
      if (nomeCompletoController.text == "" ||
          emailController.text == "" ||
          passwordController.text == "") {
        return "Preencha todos os campos";
      }

      var usuario = Usuario(
          nomeCompletoController.text.toString(),
          emailController.text.toString(),
          dataNascimentoController.text.toString(),
          userController.text.toString(),
          passwordController.text.toString());
      await db.insertUsuario(usuario);

      return "ok";
    } catch (e) {
      return "Erro ao cadastrar";
    }
  }
}
