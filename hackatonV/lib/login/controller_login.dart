import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../models/banco.dart';
import '../models/graos_db.dart';

class LoginController extends GetxController{
  var showPassword = true.obs;

  var emailController = TextEditingController(text: '');
  var passwordController = TextEditingController(text: '');
  final db = Graos();
  List<Usuario> usuarios = [];
  
  @override
  void onInit() {
    super.onInit();
    db.connect().then((value) async {
    });
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<String> goTologin() async {
    var usuario = await db.getUsuarios();

    if (usuario != null) {
       Future.delayed(const Duration(milliseconds: 1), () {
          Get.offAllNamed('/menu');
        });
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
        backgroundColor: const Color.fromARGB(255, 192, 123, 123),
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