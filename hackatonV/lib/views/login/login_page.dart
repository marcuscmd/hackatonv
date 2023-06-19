import 'package:flutter/material.dart';
import 'package:hackaton/views/login/cadastro_login.dart';

import '../menu/menu_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


    String log = "https://api.weatherapi.com/v1/forecast.json?key=" +
      'eab7a8799f49458d9ca20455231105' +
      "&days=7&q=";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 320,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/backgroud.png'),
                  fit: BoxFit.fill
                  )
              ),
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      margin: const EdgeInsets.only(top: 60),
                      child: const Center(
                        child: Text('Login',
                        style: TextStyle(color:  Color.fromARGB(230, 245, 245, 245), fontSize: 50, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  )
                ]),
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
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(19, 149, 167, 0.3),
                          blurRadius: 20.0,
                          offset: Offset(0,10)
                        )
                      ]
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color:  Color.fromRGBO(245, 245, 245, 1)))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email ou Celular',
                              hintStyle: TextStyle(color: Colors.grey[400])
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color:  Color.fromRGBO(245, 245, 245, 1)))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Senha',
                              hintStyle: TextStyle(color: Colors.grey[400])
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
                              ]
                            )
                          ),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuPage()));
                              }, 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(114, 219, 233, 1),
                                minimumSize: const Size(300, 50),
                              ),
                              child: const Text('Acessar',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                              )))
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(                        
                          child: ElevatedButton(
                            onPressed: () => {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistroPage()))
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(212, 212, 212, 0)
                            ),
                            child: const Text('Registre aqui',
                            style: TextStyle(
                            color: Color.fromRGBO(37, 130, 173, 0.945),
                            fontWeight: FontWeight.bold,
                          )),
                        )
                      )
                ],
              ))
          ]),
      ),
    );
  }
}