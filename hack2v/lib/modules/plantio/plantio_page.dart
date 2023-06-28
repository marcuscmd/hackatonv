import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hack2v/modules/plantio/plantio_controller.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:ui' as ui;
import '../../providers/database_prop.dart';
import '../prop_info/prop_info_controller.dart';

class PlantioPage extends GetView<PlantioController> {
  const PlantioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: PlantioState(
          title: '',
        ),
      ),
    );
  }
}

class PlantioState extends StatefulWidget {
  const PlantioState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _PlantioState createState() => _PlantioState();
}

class _PlantioState extends State<PlantioState> {
  PropInfoController _controller = PropInfoController();
  Propriedade? propriedade;
  bool propriedadeSelecionada = false;
  int selectvalue = 0;

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
                    child: Image.asset(
                      'assets/plant.png',
                    )),
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
                        child: TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                propriedade?.nomePropriedade ??
                                    'Nome da Propriedade',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                              const Icon(
                                Ionicons.chevron_down_outline,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          onPressed: () {
                            openDialog();
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
                            hintText: propriedade?.tipo ?? 'Tipo de Plantio',
                            enabled: false,
                            hintStyle: TextStyle(color: Colors.grey[400])),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 35),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: const Text(
                          'Informações para o Plantio',
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
                    color: const Color.fromARGB(255, 198, 241, 239),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    children: [
                      texto(),
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

  Future openDialog() async {
    List<Propriedade> properties = await _controller.props();
    // ignore: use_build_context_synchronously
    final size = MediaQuery.of(context).size;

    // ignore: use_build_context_synchronously
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Selecione uma propriedade'),
              // ignore: sized_box_for_whitespace
              content: Container(
                height: 225,
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: size.width * 0.8,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: properties.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              RadioListTile(
                                autofocus: true,
                                title: Text(properties[index].nomePropriedade),
                                value: properties[index].id,
                                groupValue: selectvalue,
                                activeColor: Colors.black,
                                onChanged: (value) {
                                  setState(() {
                                    selectvalue = value!;
                                    propriedadeSelecionada = true;
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  // ignore: sort_child_properties_last
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    if (propriedadeSelecionada) {
                      submit(properties
                          .firstWhere((prop) => prop.id == selectvalue));
                    } else {
                      // Exiba um diálogo de erro ou uma mensagem informando que a seleção é obrigatória.
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget texto() {
    if (propriedade?.tipo == 'Trigo') {
      return const Text(
        'O trigo geralmente cresce melhor em climas de temperaturas moderadas, '
        'com uma faixa de temperatura ideal entre 15°C e 24°C. Certifique-se de escolher uma região onde essas condições climáticas sejam adequadas. '
        'O trigo prospera em solos bem drenados e férteis. O pH ideal do solo para o cultivo de trigo varia de 6 a 7. '
        'Realize testes de solo para avaliar a fertilidade e a necessidade de correções, como adição de nutrientes ou ajuste de pH. '
        'Preparação do solo: Antes de plantar, prepare o solo removendo ervas daninhas, pedras e detritos. '
        'Use técnicas de aração e gradagem para soltar o solo e melhorar a estrutura.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (propriedade?.tipo == 'Algodão') {
      return const Text(
        'O algodão é tipicamente semeado na primavera ou no início do verão, dependendo da região. '
        'Siga as recomendações da variedade escolhida para o espaçamento e a profundidade de plantio corretos. '
        'O algodão pode ser semeado em linhas ou fileiras. O algodão é uma cultura que prefere climas quentes e ensolarados. '
        'Geralmente, a temperatura ideal para o crescimento do algodão está na faixa de 24°C a 30°C durante o dia. '
        'Certifique-se de escolher uma região com um clima adequado para o cultivo do algodão. '
        'O algodão cresce melhor em solos férteis, bem drenados e profundos. O pH ideal do solo para o cultivo de algodão está na faixa de 6 a 7. '
        'Faça uma análise do solo para determinar a fertilidade e as necessidades de correção, como adição de nutrientes ou ajuste de pH. '
        'Preparação do solo: Antes do plantio, prepare o solo removendo ervas daninhas, pedras e detritos. '
        'Faça a aração e a gradagem para soltar o solo e melhorar sua estrutura.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (propriedade?.tipo == 'Soja') {
      return const Text(
        'O plantio da soja geralmente ocorre na primavera, mas pode variar dependendo da região e das condições climáticas locais. '
        'Siga as recomendações da variedade escolhida para o espaçamento e a profundidade de plantio corretos. A soja é semeada em fileiras. '
        'A soja é uma cultura de clima quente e temperaturas moderadas. A temperatura ideal para o crescimento da soja está na faixa de 20°C a 30°C durante o dia. '
        'Certifique-se de escolher uma região com um clima adequado para o cultivo da soja. '
        'A soja pode ser afetada por diversas pragas e doenças, como lagartas, percevejos e doenças fúngicas. '
        'Implemente um programa de manejo integrado de pragas, que pode envolver o uso de pesticidas, rotação de culturas, monitoramento regular e outras práticas de controle.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (propriedade?.tipo == 'Arroz') {
      return const Text(
        'O arroz pode ser plantado por meio de sementes diretamente no solo ou através de mudas pré-germinadas. '
        'O método de plantio depende da variedade e das práticas de cultivo específicas da região. '
        'Siga as recomendações da variedade escolhida para o espaçamento e a profundidade de plantio corretos. '
        'O arroz é uma cultura que se desenvolve melhor em regiões com clima quente e úmido. '
        'A temperatura ideal para o crescimento do arroz está na faixa de 20°C a 35°C durante o dia. '
        'Certifique-se de escolher uma região com um clima adequado para o cultivo do arroz. '
        'O arroz prefere solos alagados e com boa capacidade de retenção de água. O pH ideal do solo para o cultivo do arroz está na faixa de 6 a 7. '
        'Realize uma análise do solo para determinar a fertilidade e as necessidades de correção, como adição de nutrientes ou ajuste de pH.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return const Text(
      '',
      style: TextStyle(
        color: Colors.black,
        fontSize: 17,
      ),
    );
  }

  void submit(Propriedade propriedadeSelecionada) {
    setState(() {
      propriedade = propriedadeSelecionada;
    });
    Get.back();
  }
}
