import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../providers/database_prop.dart';
import '../../providers/database_user.dart';
import '../login/login_controller.dart';

class PropInfoController extends GetxController {
  final db = DataBaseProvider();
  var dataController = TextEditingController(text: '');

  @override
  void onInit() {
    super.onInit();
    db.initDb().then((value) async {});
  }

  LoginController cd = LoginController();
  RxBool isEditing = false.obs;
  RxBool isEditingData = false.obs;
  void toggleEditing() {
    isEditing.value = !isEditing.value; // Inverte o estado de edição
    isEditingData.value = !isEditingData.value;
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
