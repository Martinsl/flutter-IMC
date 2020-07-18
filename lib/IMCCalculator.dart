import 'package:flutter/material.dart';
import 'dart:math';

class IMCCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new IMCState();
  }
}

class IMCState extends State<IMCCalculator> {
  String imcResult;
  Color imcColor = Colors.blue; // default color

  TextEditingController heightFieldController = new TextEditingController();
  TextEditingController weightFieldController = new TextEditingController();

  String createString(double imc, String str) {
    if (imc > 99.99) {
      imc = 99.99;
    }
    return imc.toStringAsFixed(2) + ' - $str';
  }

  @override
  void initState() {
    super.initState();

    // with these addListeners our controllers will call calculateIMC
    weightFieldController.addListener(calculateIMC);
    heightFieldController.addListener(calculateIMC);
  }

  void calculateIMC() {
    if (heightFieldController.text == '' || weightFieldController.text == '') {
      // leave early
      return;
    }

    double height = double.parse(heightFieldController.text);
    double weight = double.parse(weightFieldController.text);

    setState(() {
      imcColor = Colors.green;
      double imc = weight / pow(height / 100, 2);
      String weightPhrase = '';

      if (imc < 17) {
        imcColor = Colors.red;
        weightPhrase = 'Muito abaixo do peso';
      } else if (imc < 18.5) {
        imcColor = Colors.pink;
        weightPhrase = 'Abaixo do peso';
      } else if (imc < 25) {
        weightPhrase = 'Peso normal';
      } else if (imc < 30) {
        imcColor = Colors.pink;
        weightPhrase = 'Acima do peso';
      } else if (imc < 35) {
        imcColor = Colors.red;
        weightPhrase = 'Obesidade I';
      } else if (imc < 40) {
        imcColor = Colors.red[700];
        weightPhrase = 'Obesidade II (severa)';
      } else {
        imcColor = Colors.red[900];
        weightPhrase = 'Obesidade III (mórbida)';
      }
      imcResult = createString(imc, weightPhrase);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('IMC - Lucas Silva Martins'),
      ),
      body: new ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 50.0),
            child: Text(
              'Calcule seu IMC',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            // color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new TextField(
                  controller: heightFieldController,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    labelText: 'Altura em cm',
                    icon: new Icon(Icons.straighten),
                  ),
                ),
                new Padding(padding: const EdgeInsets.all(10.0)),
                new TextField(
                  controller: weightFieldController,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    labelText: 'Peso em KG',
                    icon: new Icon(Icons.inbox),
                  ),
                ),
                new Padding(padding: const EdgeInsets.all(8.0)),
              ],
            ),
          ),
          new Padding(padding: const EdgeInsets.all(5.5)),
          new Container(
            alignment: Alignment.topCenter,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(padding: const EdgeInsets.all(8)),
                new Text(
                  imcResult != null ? imcResult : '',
                  style: new TextStyle(
                      color: imcColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
