import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(children: [
          Container(
            height: 320,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/backgroud.png'),
                    fit: BoxFit.fill)),
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 180,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    margin: const EdgeInsets.only(top: 60),
                    child: const Center(
                      child: Text(
                        'AgroTempo',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 254, 254),
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 120,
                  child: Container(
                    margin: const EdgeInsets.only(top: 60),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Color.fromARGB(230, 0, 0, 0),
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
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
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(245, 245, 245, 1),
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(245, 245, 245, 1),
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
                          var result = await controller.goTologin();
                          if (result != 'ok') {
                            final snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Erro ao Logar!',
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
                            controller.toast('Logado com Sucesso!');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(114, 219, 233, 1),
                          minimumSize: const Size(300, 50),
                        ),
                        child: const Text(
                          'Acessar',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/cadastro');
                    },
                    child: const Text(
                      'Registre aqui',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ))
        ]),
      ),
    );
  }
}
