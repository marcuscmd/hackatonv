import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../providers/database_user.dart';

class LoginController extends GetxController {
  var showPassword = true.obs;

  var emailController = TextEditingController(text: '');
  var passwordController = TextEditingController(text: '');
  final db = DataBaseProvider();
  List<Usuario> usuarios = [];

  @override
  void onInit() {
    super.onInit();
    db.initDb().then((value) async {});
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<String> goTologin() async {
    var usuario = await db.getUsuario(
        emailController.text,
        passwordController
            .text); // Armazena o ID do usuário atual na variável userId

    bool isLoggedIn = true;
    //if (usuario != null) await db.updateUserLoggedInStatus(isLoggedIn, usuario);
    if (usuario != null) {
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.offAllNamed('/menu');
      });
      db.deslogar();
      await db.updateUserLoggedInStatus(isLoggedIn, usuario);
      return "ok";
    }

    return "Senha ou Email incorretos";
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

  load() {
    db.getAllUsuarios().then((value) {
      usuarios = value;
      emailController.text = "";
      passwordController.text = "";
    });
  }
}
