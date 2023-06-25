import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MenuController>(() => MenuController());
  }

}