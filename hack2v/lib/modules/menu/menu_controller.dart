import 'package:get/get.dart';

import '../../providers/database_user.dart';

class MenuController extends GetxController {
  final db = DataBaseProvider();

  void deslogando() {
    db.deslogar();
  }
}
