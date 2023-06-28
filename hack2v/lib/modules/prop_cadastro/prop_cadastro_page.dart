import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hack2v/modules/prop_cadastro/prop_cadastro_controller.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:ionicons/ionicons.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../core/app_theme.dart';

var newFormat = DateFormat("dd/MM/yyyy");
var dt = DateTime.now();
String updatedDt = newFormat.format(dt);
String data = DateTime.now().toIso8601String();

class PropCadastroPage extends GetView<PropCadastroController> {
  const PropCadastroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
        textDirection: ui.TextDirection.ltr,
        child: PropCadastroState(),
      ),
    );
  }
}

class PropCadastroState extends StatefulWidget {
  const PropCadastroState({super.key});

  @override
  State<PropCadastroState> createState() => _PropCadastroState();
}

class _PropCadastroState extends State<PropCadastroState> {
  PropCadastroController _controller = PropCadastroController();

  var mask = MaskTextInputFormatter(mask: "##/##/####");

  load() {
    setState(() {
      _controller.tipoController = selectvalue;
    });
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
            secondary:  const Color.fromARGB(255, 100, 191, 233),
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
        _controller.dataController.text = updatedDt;
      });
    }
  }

  String selectvalue = '';
  List<PropCadastroState> prop = [];

  TextEditingController nomePropriedade = TextEditingController();
  TextEditingController tamanhoHectar = TextEditingController();
  TextEditingController dataPlantio = TextEditingController();
  //double _valorHectar = 0;
  String dataString = '';

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: SystemUiOverlay.values);
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        // width: size.width,
        // height: size.height,
        padding: const EdgeInsets.all(0),
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Container(
              height: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/backgroud.png'),
                      fit: BoxFit.fill)),
              child: Stack(children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 100),
                    width: 210,
                    height: 210,
                    //left: 75,
                    child: const Icon(
                      Icons.badge_outlined,
                      size: 100,
                    ),
                  ),
                ),
              ]),
            ),
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
                        'Cadastro da Propriedade',
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
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Color.fromRGBO(200, 200, 200, 1),
                        ))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nome da Propiedade',
                              hintStyle: TextStyle(color: Colors.grey[400])),
                          controller: _controller.nomePropController,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Insira o nome de uma propriedade';
                            }
                            return null;
                          },
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
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tamanho do Hectar',
                            hintStyle: TextStyle(color: Colors.grey[400])),
                        controller: _controller.hectarController,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'Insira o tamanho do hectare';
                          }
                          if (double.tryParse(value.toString()) == null) {
                            return 'Valor inválido. Insira um número válido para o tamanho do hectare';
                          }
                          return null;
                        },
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
                                "Data do Plantio",
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
                              _controller.tipoController,
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
                      ),
                      onPressed: () {
                        _controller.cadastro();
                      },
                      child: const Text('Cadastrar',
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
      ),
    );
  }

  Future openDialog() async {
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
                          selectvalue = value as String;
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
                          selectvalue = value as String;
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
                          selectvalue = value as String;
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
                          selectvalue = value as String;
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
                  onPressed: submit,
                ),
              ],
            );
          },
        );
      },
    );
  }

  void submit() {
    load();
    Get.back();
  }
}
