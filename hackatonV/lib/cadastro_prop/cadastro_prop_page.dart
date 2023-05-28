import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackaton/menu/menu_page.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../models/appCafe_dao.dart';
import 'cadastro_prop.dart';

class CadastroPropPage extends StatefulWidget {
  const CadastroPropPage({super.key});

  @override
  State<CadastroPropPage> createState() => _CadastroPropPage();
}

class _CadastroPropPage extends State<CadastroPropPage> {
  List<CadastroPropPage> prop = [];

  TextEditingController nomePropriedade = TextEditingController();
  TextEditingController tamanhoHectar = TextEditingController();
  TextEditingController dataPlantio = TextEditingController();
  double _valorHectar = 0;
  String dataString = '';

  final AppCafeDao dao = AppCafeDao();

  _CadastroPropPage() {
    dao.connect().then((value) {
      load();
    });
  }

  load() {
    dao.list().then((value) {
      setState(() {
        prop = value.cast<CadastroPropPage>();
        nomePropriedade.text = "";
        tamanhoHectar.text = "";
        dataPlantio.text = "";
      });
    });
  }

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
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 30),
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
                          controller: nomePropriedade,
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
                        controller: tamanhoHectar,
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
                        keyboardType: TextInputType.number,
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.digitsOnly,
                        //   LengthLimitingTextInputFormatter(8),
                        //   MaskTextInputFormatter(
                        //     mask: '00/00/0000',
                        //     filter: {"0": RegExp(r'[0-9]')},
                        //   ),
                        // ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Data do Plantio',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        controller: dataPlantio,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira a data de plantio';
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
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(114, 219, 233, 1),
                        Color.fromRGBO(37, 130, 173, 0.945)
                      ])),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(310, 100),
                        backgroundColor: Color.fromARGB(82, 114, 219, 233),
                      ),
                      onPressed: () {
                        // if (nomePropriedade.text.trim() != '') {
                        //   //String dataString = dataPlantio.text;
                        //   DateTime dataPlantio =
                        //       DateFormat('dd/MM/yyyy').parse(PegarData());
                        //   int dataTimestamp =
                        //       dataPlantio.millisecondsSinceEpoch;
                        //   var dep = CadastroProp(
                        //     nomePropriedade: nomePropriedade.text,
                        //     dataPlantio: dataTimestamp,
                        //     tamanhoHectar: _valorHectar =
                        //         double.parse(tamanhoHectar.text),
                        //   );
                        //   dao.insert(dep).then((value) {
                        //     load();
                        //   });
                        // }
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuPage()));
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

  String PegarData() {
    String dataString = dataPlantio.text;
    return dataString;
  }
}
