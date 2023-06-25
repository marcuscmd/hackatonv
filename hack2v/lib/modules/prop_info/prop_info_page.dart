import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hack2v/modules/prop_info/prop_info_controller.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PropInfoPage extends GetView<PropInfoController> {
  const PropInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(children: [
          Container(
            height: 250,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/backgroud.png'),
                    fit: BoxFit.fill)),
            child: Stack(children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 150),
                  width: 210,
                  height: 30,
                  //left: 75,
                  child: const Icon(
                    Icons.info_outline,
                    size: 100,
                  ),
                ),
              ),
            ]),
          ),
          Container(
            child: Stack(children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 0, right: 10, bottom: 5),
                      margin: const EdgeInsets.only(top: 0, right: 20),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.border_color_outlined,
                            size: 35,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Container(
            child: Stack(children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: const Center(
                    child: Text(
                      'Informações da Propriedade',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(230, 12, 0, 0),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
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
                            offset: Offset(0, 10))
                      ]),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        padding: const EdgeInsets.all(0),
                        width: 350,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(200, 200, 200, 1),
                            ),
                          ),
                        ),
                        child: TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Nome da Propiedade',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                              Icon(
                                Ionicons.chevron_down_outline,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          onPressed: () {
                            //openDialog();
                          },
                          style: const ButtonStyle(
                            alignment:
                                Alignment.centerLeft, // Alinhamento à esquerda
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
                            offset: Offset(0, 10))
                      ]),
                  child: Column(children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Color.fromRGBO(200, 200, 200, 1),
                      ))),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tamanho do Hectar',
                            hintStyle: TextStyle(color: Colors.grey[400])),
                      ),
                    ),
                  ]),
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
                            offset: Offset(0, 10))
                      ]),
                  child: Column(children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Color.fromRGBO(200, 200, 200, 1),
                      ))),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(8),
                          MaskTextInputFormatter(
                              mask: '##/##/####',
                              filter: {"#": RegExp(r'[0-9]')})
                        ],
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Data do Plantio',
                            hintStyle: TextStyle(color: Colors.grey[400])),
                      ),
                    ),
                  ]),
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
                            offset: Offset(0, 10))
                      ]),
                  child: Column(children: [
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
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tipo do Plantio',
                            hintStyle: TextStyle(color: Colors.grey[400])),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 30),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(114, 219, 233, 1),
                        Color.fromRGBO(37, 130, 173, 0.945)
                      ])),
                  child: const Center(
                    child: Text('Salvar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 37,
                        )),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
