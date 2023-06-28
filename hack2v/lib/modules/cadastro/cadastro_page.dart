import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:ui' as ui;

import 'cadastro_controller.dart';

var newFormat = DateFormat("dd/MM/y");
var dt = DateTime.now();
String updatedDt = newFormat.format(dt);
String data = DateTime.now().toIso8601String();

class CadastroPage extends GetView<CadastroController> {
  const CadastroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: CadastroState(
          title: '',
        ),
      ),
    );
  }
}

class CadastroState extends StatefulWidget {
  const CadastroState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _LoginRegistro createState() => _LoginRegistro();
}

class _LoginRegistro extends State<CadastroState>
    with SingleTickerProviderStateMixin {
  CadastroController controller = Get.put(
    CadastroController(),
  );
  var mask = MaskTextInputFormatter(mask: "##/##/####");
  Future<void> _data(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dt,
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
      cancelText: "CANCELAR",
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          primaryColor: const Color.fromARGB(255, 130, 247, 247),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          colorScheme: const ColorScheme.light(
            primary: Color.fromARGB(255, 100, 191, 233),
          ).copyWith(
            secondary: const Color.fromARGB(255, 100, 191, 233),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        dt = picked;
        data = dt.toIso8601String();
        controller.dataNascimentoController.text = data;
        updatedDt = newFormat.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 280,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/backgroud.png'),
                    fit: BoxFit.fill),
              ),
              child: Stack(children: [
                Positioned(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: const Center(
                      child: Text(
                        'Registro',
                        style: TextStyle(
                            color: Color.fromARGB(230, 245, 245, 245),
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const SizedBox(height: 0),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(19, 149, 167, 0.3),
                          blurRadius: 20.0,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(200, 200, 200, 1),
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: controller.nomeCompletoController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nome',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(19, 149, 167, 0.3),
                          blurRadius: 20.0,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(200, 200, 200, 1),
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(19, 149, 167, 0.3),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          )
                        ]),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          padding: const EdgeInsets.all(0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(200, 200, 200, 1),
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: const Text(
                                  "Data de Nascimento",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                isThreeLine: false,
                                subtitle: Text(
                                  updatedDt,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                ),
                                onTap: () => _data(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(19, 149, 167, 0.3),
                          blurRadius: 20.0,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(200, 200, 200, 1),
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: controller.userController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Usuario',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(19, 149, 167, 0.3),
                          blurRadius: 20.0,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(200, 200, 200, 1),
                              ),
                            ),
                          ),
                          child: Obx(
                            () => TextFormField(
                              controller: controller.passwordController,
                              obscureText: controller.showPassword.value,
                              cursorColor: Colors.grey[400],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Senha',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontStyle: FontStyle.italic,
                                ),
                                suffixIcon: GestureDetector(
                                  child: Icon(
                                    controller.showPassword.value == false
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off,
                                    color: Colors.black54,
                                  ),
                                  onTap: () {
                                    controller.toggleShowPassword();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(114, 219, 233, 1),
                          Color.fromRGBO(37, 130, 173, 0.945)
                        ],
                      ),
                    ),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          var result = await controller.cadastro();
                          if (result != "ok") {
                            final snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Erro ao registrar!',
                                message: result.toString(),
                                contentType: ContentType.failure,
                                color: const Color.fromARGB(255, 32, 82, 77),
                              ),
                            );
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          } else {
                            controller.toast('Registrado com Sucesso!');
                            Get.toNamed('/login');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(114, 219, 233, 1),
                          minimumSize: const Size(300, 50),
                        ),
                        child: const Text(
                          'Registrar',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
