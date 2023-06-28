import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hack2v/routes/pages.dart';
import 'package:hack2v/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import "package:i18n_extension/i18n_widget.dart";


void main() async {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.login,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    locale: const Locale('pt', 'BR'),
    supportedLocales: const [
      Locale('pt', 'BR'),
    ],
  ));

}
