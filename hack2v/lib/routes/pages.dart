import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hack2v/modules/menu/menu_page.dart';
import 'package:hack2v/modules/perdas/perda_binding.dart';
import 'package:hack2v/modules/perdas/perda_page.dart';
import 'package:hack2v/routes/routes.dart';

import '../modules/adubo/adubo_binding.dart';
import '../modules/adubo/adubo_page.dart';
import '../modules/cadastro/cadastro_binding.dart';
import '../modules/cadastro/cadastro_page.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_page.dart';
import '../modules/menu/menu_binding.dart';
import '../modules/plantio/plantio_binding.dart';
import '../modules/plantio/plantio_page.dart';
import '../modules/prop_cadastro/prop_cadastro_binding.dart';
import '../modules/prop_cadastro/prop_cadastro_page.dart';
import '../modules/prop_info/prop_info_page.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.cadastro,
      page: () => const CadastroPage(),
      binding: CadastroBinding(),
    ),
    GetPage(
      name: Routes.menu,
      page: () => const MenuPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: Routes.propcadastro,
      page: () => const PropCadastroPage(),
      binding: PropCadastroBinding(),
    ),
    GetPage(
      name: Routes.propinfo,
      page: () => const PropInfoPage(),
      binding: PropCadastroBinding(),
    ),
    GetPage(
      name: Routes.plantio,
      page: () => PlantioPage(),
      binding: PlantioBinding(),
    ),
    GetPage(
      name: Routes.adubo,
      page: () => AduboPage(),
      binding: AduboBinding(),
    ),
    GetPage(
      name: Routes.perda,
      page: () => const PerdasPage(),
      binding: PerdaBinding(),
    ),
  ];
}
