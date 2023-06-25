import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hack2v/modules/plantio/plantio_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class PlantioPage extends GetView<PlantioController> {
  const PlantioPage({super.key});

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
                  margin: const EdgeInsets.only(bottom: 100),
                  width: 120,
                  height: 120,
                  //left: 75,
                  child: Image.asset('assets/plant.png',
                  )
                ),
              ),
            ]),
          ),
          Container(
            child: Stack(children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 0),
                  child: const Center(
                    child: Text(
                      'Informações de Plantio',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(230, 12, 0, 0),
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
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
                  child: Column(
                    children: [
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
                              hintText: 'Nome da Propiedade',
                              hintStyle: TextStyle(color: Colors.grey[400])),
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
                const SizedBox(height: 30),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: const Text(
                          'Época ideal',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          selectionColor: Color.fromARGB(123, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 330,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 192, 181, 170),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    children: const [
                      Text('• Uma opção de adubo recomendada para o café catuaí é o NPK 20-05-20, que apresenta uma proporção balanceada de nutrientese é indicado para a fase de produção das plantas. Outra opção é o adubo orgânico, como esterco de avesou compostos, que pode fornecer nutrientes de forma mais gradual e sustentável para as plantas.',
                      style: TextStyle(
                      fontSize: 20,
                    ),)
                    ],
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
