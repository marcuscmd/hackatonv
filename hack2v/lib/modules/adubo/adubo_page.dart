import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hack2v/modules/adubo/adubo_controller.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:ui' as ui;
import '../../providers/database_prop.dart';
import '../prop_info/prop_info_controller.dart';

class AduboPage extends GetView<AduboController> {
  const AduboPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: AduboState(
          title: '',
        ),
      ),
    );
  }
}

class AduboState extends StatefulWidget {
  const AduboState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _AduboState createState() => _AduboState();
}

class _AduboState extends State<AduboState> {
  int selectvalue = 0;
  bool propriedadeSelecionada = false;
  PropInfoController _controller = PropInfoController();
  Propriedade? propriedade;

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
                  width: 100,
                  height: 90,
                  child: Image.asset(
                    'assets/fertilizer.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 30),
            child: Column(
              children: [
                Center(
                  child: Container(
                    // margin: const EdgeInsets.only(top: 60),
                    child: const Center(
                      child: Text(
                        'Adubos Recomendados',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 37,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
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
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: const Text(
                          'Adubo Recomendado',
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
                    children: [texto()],
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
        'Nitrogênio (N). O nitrogênio é um nutriente essencial para o crescimento e desenvolvimento do trigo. '
        'Pode ser aplicado na forma de ureia, nitrato de amônio, sulfato de amônio, entre outros fertilizantes nitrogenados. '
        'A quantidade de nitrogênio a ser aplicada varia de acordo com a análise do solo e as necessidades da cultura em cada estágio de crescimento. '
        'Fósforo (P). O fósforo desempenha um papel crucial no estabelecimento inicial das raízes e no desenvolvimento dos sistemas radiculares do trigo. '
        'Os fertilizantes fosfatados, como superfosfato simples ou fosfato diamônico, podem ser utilizados para fornecer fósforo ao solo. ',
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (propriedade?.tipo == 'Algodão') {
      return const Text(
        'Potássio (K). O potássio é importante para o crescimento e desenvolvimento geral das plantas, bem como para a resistência a doenças e estresses. '
        'Fertilizantes potássicos, como cloreto de potássio ou sulfato de potássio, podem ser aplicados para suprir as necessidades de potássio do algodoeiro. '
        'Cálcio (Ca) e Magnésio (Mg). Esses nutrientes são essenciais para a saúde das plantas e contribuem para a estrutura das células e a fotossíntese. '
        'Eles podem ser fornecidos por meio de fertilizantes como o calcário (fonte de cálcio) e o sulfato de magnésio.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (propriedade?.tipo == 'Soja') {
      return const Text(
        'Fósforo (P). O fósforo desempenha um papel importante no desenvolvimento das raízes, na floração e na formação de vagens da soja. '
        'Os fertilizantes fosfatados, como superfosfato simples ou fosfato diamônio, podem ser utilizados para fornecer fósforo ao solo, '
        'especialmente se houver deficiência detectada por meio de análise de solo. '
        'Potássio (K). O potássio é essencial para o desenvolvimento da soja, especialmente para a formação de vagens e grãos. '
        'Fertilizantes potássicos, como cloreto de potássio ou sulfato de potássio, podem ser aplicados para suprir as necessidades de potássio do solo, '
        'se houver deficiência detectada por meio de análise de solo. '
        'Cálcio (Ca) e Magnésio (Mg). Esses nutrientes são importantes para o desenvolvimento geral da planta de soja. '
        'O cálcio contribui para a estrutura das células e a formação adequada de raízes, enquanto o magnésio é necessário para a fotossíntese. '
        'Podem ser fornecidos por meio de fertilizantes como o calcário (fonte de cálcio) e o sulfato de magnésio.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (propriedade?.tipo == 'Arroz') {
      return const Text(
        'Cálcio (Ca) e Magnésio (Mg). Esses nutrientes são importantes para o desenvolvimento da estrutura das células e para a atividade enzimática na soja. '
        'O calcário (carbonato de cálcio) é frequentemente utilizado para corrigir a acidez do solo e fornecer cálcio. '
        'O sulfato de magnésio é uma opção comum para suprir a demanda de magnésio. \n'
        'Potássio (K). O potássio é essencial para o crescimento e desenvolvimento geral da planta de soja. '
        'Ele desempenha um papel importante na resistência a doenças e estresses, na formação de grãos e no teor de óleo. '
        'Fertilizantes potássicos, como o cloreto de potássio ou o sulfato de potássio, são amplamente utilizados para suprir as necessidades de potássio da soja.',
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
