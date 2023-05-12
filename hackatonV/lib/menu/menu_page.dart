import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {

  static String chave_api ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 250,
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        color: Colors.blue[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              height: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(44, 145, 145, 0.719),
                    Color.fromRGBO(137, 236, 236, 0.718),
                  ]
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 255, 255),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(10)
              ),
              child: ,
            )
          ],
        ),
      ),
    );
  }
}