// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hack2v/modules/prop_info/prop_info_controller.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:ui' as ui;

import '../../providers/database_prop.dart';

var newFormat = DateFormat("dd/MM/yyyy");
var dt = DateTime.now();
String updatedDt = newFormat.format(dt);
String data = DateTime.now().toIso8601String();

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
  @override
  void initState() {
    super.initState();
  }

  Future<void> _data(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dt,
      firstDate: DateTime(1900),
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
        updatedDt = newFormat.format(picked);
        _dataController.text = updatedDt;
      });
    }
  }

  final PropInfoController _controller = PropInfoController();
  int selectvalue = 0;
  Propriedade? propriedade;
  bool propriedadeSelecionada = false;
  final TextEditingController _hectarController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  String selectvalue2 = '';
  @override
  Widget build(BuildContext context) {
    bool isEditing = false;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        Container(
          height: 250,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/backgroud.png'), fit: BoxFit.fill)),
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
                          if (_controller.isEditing.isTrue ||
                              _controller.isEditingData.isTrue) {
                            _controller.toast('Modo Edição Desativado!');
                          } else
                            _controller.toast('Modo Edição Ativado!');
                          setState(() {
                            _controller.toggleEditing();
                            // Inverte o estado de edição ao clicar no ícone da caneta
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
                      child: AbsorbPointer(
                        absorbing: !_controller.isEditingData.value,
                        child: IgnorePointer(
                          ignoring: !_controller.isEditingData.value,
                          child: TextFormField(
                            controller: _dataController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: updatedDt == DateTime.now()
                                    ? updatedDt
                                    : 'Data Plantio',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                                suffixIcon: GestureDetector(
                                  child: const Icon(Icons.arrow_drop_down),
                                  onTap: () {
                                    setState(() {
                                      _data(context);
                                    });
                                  },
                                )),
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
                    child: AbsorbPointer(
                      absorbing: !_controller.isEditingData.value,
                      child: IgnorePointer(
                        ignoring: !_controller.isEditingData.value,
                        child: TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _tipoController.text != ""
                                    ? _tipoController.text
                                    : 'Tipo de Plantio',
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
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 45),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(colors: [
                      Color.fromRGBO(114, 219, 233, 1),
                      Color.fromRGBO(37, 130, 173, 0.945),
                    ])),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(310, 100),
                        backgroundColor:
                            const Color.fromARGB(255, 100, 191, 233),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                    onPressed: () {
                      saveChanges();
                      _controller.toast('Editado com Sucesso!');
                      Get.toNamed('/menu');
                    },
                    child: const Text('Salvar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 37,
                        )),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ]),
    );
  }

  Future openDialog() async {
    List<Propriedade> properties = await _controller.props();
    final size = MediaQuery.of(context).size;

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
      updatedDt = propriedadeSelecionada.data;
      _dataController.text = propriedadeSelecionada.data;
      _hectarController.text = propriedadeSelecionada.hectar.toString();
      _tipoController.text = propriedadeSelecionada.tipo;
    });
    Get.back();
  }

  bool saveChanges() {
    try {
      if (propriedade != null) {
        Propriedade newprop = Propriedade(
            id: propriedade!.id,
            nomePropriedade: propriedade!.nomePropriedade,
            hectar: double.parse(valorHectar()),
            data: valorData(),
            tipo: _tipoController.text,
            idUsuario: propriedade!.idUsuario);

        // Chamar o método de salvamento no controlador ou serviço correspondente
        _controller.savePropriedade(newprop);
      }
      return true;
    } catch (e) {
      return false;
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
                      groupValue: selectvalue2,
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
                      groupValue: selectvalue2,
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
                      groupValue: selectvalue2,
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
                      groupValue: selectvalue2,
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
                    onPressed: () {
                      submit2(selectvalue2);
                    }),
              ],
            );
          },
        );
      },
    );
  }

  void submit2(String value) {
    setState(() {
      _tipoController.text = value;
    });
    Get.back();
  }
}
