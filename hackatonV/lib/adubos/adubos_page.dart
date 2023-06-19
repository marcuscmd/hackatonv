import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AduboPage extends StatefulWidget {
  const AduboPage({super.key});

  @override
  State<AduboPage> createState() => _AduboPage();
}

class _AduboPage extends State<AduboPage> {
  int? selectvalue;
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
                            children: const [
                              Text(
                                'Selecione uma Propriedade',
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
                    color: const Color.fromARGB(255, 192, 181, 170),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    children: const [
                      Text(
                        '• Uma opção de adubo recomendada para o café catuaí é o NPK 20-05-20, que apresenta uma proporção balanceada de nutrientese é indicado para a fase de produção das plantas. Outra opção é o adubo orgânico, como esterco de avesou compostos, que pode fornecer nutrientes de forma mais gradual e sustentável para as plantas.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
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
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Selecione uma Propriedade'),
              content: Container(
                height: 225,
                child: Column(
                  children: [
                    RadioListTile(
                      autofocus: true,
                      title: const Text('Prop1'),
                      value: 1,
                      groupValue: selectvalue,
                      activeColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          selectvalue = value as int?;
                        });
                      },
                    ),
                    // RadioListTile(
                    //   autofocus: true,
                    //   title: const Text('Trigo'),
                    //   value: 2,
                    //   groupValue: selectvalue,
                    //   activeColor: Colors.black,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       selectvalue = value as int?;
                    //     });
                    //   },
                    // ),
                    // RadioListTile(
                    //   autofocus: true,
                    //   title: const Text('Algodão'),
                    //   value: 3,
                    //   groupValue: selectvalue,
                    //   activeColor: Colors.black,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       selectvalue = value as int?;
                    //     });
                    //   },
                    // ),
                    // RadioListTile(
                    //   autofocus: true,
                    //   title: const Text('Soja'),
                    //   value: 4,
                    //   groupValue: selectvalue,
                    //   activeColor: Colors.black,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       selectvalue = value as int?;
                    //     });
                    //   },
                    // ),
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
    Navigator.of(context).pop();
  }
}
