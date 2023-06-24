import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hackaton/routes/routes.dart';

import '../login/login_binding.dart';
import '../login/login_page.dart';
import '../menu/menu_page.dart';
import '../register_login/login_registro.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.cadastro,
      page: () => const LoginRegistro(),
    ),
    GetPage(
      name: Routes.menu,
      page: () => const MenuPage(),
    ),
  ];
}
