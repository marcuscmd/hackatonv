// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hack2v/modules/prop_info/prop_info_controller.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:ui' as ui;

import '../../providers/database_prop.dart';

class PropInfoPage extends GetView<PropInfoController> {
  const PropInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: PropInfoState(
          title: '',
        ),
      ),
    );
  }
}

class PropInfoState extends StatefulWidget {
  const PropInfoState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _PropInfo createState() => _PropInfo();
}

class _PropInfo extends State<PropInfoState> {
  PropInfoController _controller = PropInfoController();
  int selectvalue = 0;
  Propriedade? propriedade;
  bool propriedadeSelecionada = false;
  TextEditingController _hectarController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
  TextEditingController _tipoController = TextEditingController();
  String selectvalue2 = '';
  @override
  Widget build(BuildContext context) {
    bool isEditing = false;
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
                          onPressed: () {
                            setState(() {
                              _controller
                                  .toggleEditing(); // Inverte o estado de edição ao clicar no ícone da caneta
                            });
                          },
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
                            children: [
                              Text(
                                propriedade?.nomePropriedade ??
                                    'Nome da Propriedade',
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
                      child: AbsorbPointer(
                        absorbing: !_controller.isEditing.value,
                        child: IgnorePointer(
                          ignoring: !_controller.isEditing.value,
                          child: TextFormField(
                            controller: _hectarController,
                            decoration: InputDecoration(
                                labelText: propriedade?.hectar.toString() ??
                                    'Tamanho do Hectar',
                                border: InputBorder.none,
                                hintText: propriedade?.hectar.toString() ??
                                    'Tamanho do Hectar',
                                hintStyle: TextStyle(color: Colors.grey[400])),
                          ),
                        ),
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
                      child: AbsorbPointer(
                        absorbing: !_controller.isEditing.value,
                        child: IgnorePointer(
                          ignoring: !_controller.isEditing.value,
                          child: TextFormField(
                            controller: _dataController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(8),
                              MaskTextInputFormatter(
                                  mask: '##/##/####',
                                  filter: {"#": RegExp(r'[0-9]')})
                            ],
                            decoration: InputDecoration(
                                labelText:
                                    propriedade?.data ?? 'Data do Plantio',
                                border: InputBorder.none,
                                hintText:
                                    propriedade?.data ?? 'Data do Plantio',
                                hintStyle: TextStyle(color: Colors.grey[400])),
                          ),
                        ),
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
                              propriedade?.tipo ?? 'Tipo de Plantio',
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
                          openDialog2();
                        },
                        style: const ButtonStyle(
                          alignment:
                              Alignment.centerLeft, // Alinhamento à esquerda
                        ),
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
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        saveChanges();
                      });
                    },
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 37,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Cor do botão
                      padding: const EdgeInsets.symmetric(
                          vertical: 15), // Espaçamento interno vertical
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Borda arredondada
                      ),
                    ),
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
                    Container(
                      height: 150,
                      width: 150,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: properties.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
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

  void submit(Propriedade propriedadeSelecionada) {
    setState(() {
      propriedade = propriedadeSelecionada;
    });
    Get.back();
  }

  void saveChanges() {
    if (propriedade != null) {
      Propriedade newprop = Propriedade(
          id: propriedade!.id,
          nomePropriedade: propriedade!.nomePropriedade,
          hectar: double.parse(valorHectar()),
          data: valorData(),
          tipo: valorTipo(),
          idUsuario: propriedade!.idUsuario);

      // Chamar o método de salvamento no controlador ou serviço correspondente
      _controller.savePropriedade(newprop);
    }
  }

  String valorHectar() {
    String valor = _hectarController.text;
    return valor;
  }

  String valorData() {
    String valor = _dataController.text;
    return valor;
  }

  String valorTipo() {
    String valor = _tipoController.text;
    return valor;
  }

  Future openDialog2() async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Selecione um plantio'),
              content: Container(
                height: 225,
                child: Column(
                  children: [
                    RadioListTile(
                      autofocus: true,
                      title: const Text('Arroz'),
                      value: 'Arroz',
                      groupValue: selectvalue,
                      activeColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          selectvalue2 = value as String;
                        });
                      },
                    ),
                    RadioListTile(
                      autofocus: true,
                      title: const Text('Trigo'),
                      value: 'Trigo',
                      groupValue: selectvalue,
                      activeColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          selectvalue2 = value as String;
                        });
                      },
                    ),
                    RadioListTile(
                      autofocus: true,
                      title: const Text('Algodão'),
                      value: 'Algodão',
                      groupValue: selectvalue,
                      activeColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          selectvalue2 = value as String;
                        });
                      },
                    ),
                    RadioListTile(
                      autofocus: true,
                      title: const Text('Soja'),
                      value: 'Soja',
                      groupValue: selectvalue,
                      activeColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          selectvalue2 = value as String;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: submit2,
                ),
              ],
            );
          },
        );
      },
    );
  }

  void submit2() {
    Get.back();
  }
}
