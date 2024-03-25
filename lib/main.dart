// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora IMC",
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
    ),
    home: const Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _textInfo = "";

  void _resetCampos() {
    _formKey.currentState!.reset();
    pesoController.clear();
    alturaController.clear();
    setState(() {
      _textInfo = "";
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      //debugPrint("$imc");
      if (imc < 18.6) {
        _textInfo = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _textInfo = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _textInfo = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _textInfo = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _textInfo = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _textInfo = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textStyle = GoogleFonts.quicksand(
        textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary));

    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC',
            style: GoogleFonts.chicle(
                textStyle: TextStyle(
                    color: theme.colorScheme.onPrimary, fontSize: 40))),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        leading: IconButton(
          onPressed: () => _dialogBuilder(context),
          icon: Icon(
            Icons.help_outline,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: _resetCampos,
              icon: Icon(Icons.refresh, color: theme.colorScheme.onPrimary))
        ],
      ),
      backgroundColor: theme.colorScheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.scale, size: 120, color: theme.primaryColor),
                TextFormField(
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)", labelStyle: textStyle),
                    textAlign: TextAlign.center,
                    style: textStyle,
                    controller: pesoController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira seu peso!";
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)", labelStyle: textStyle),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: theme.primaryColor, fontSize: 25.0),
                    controller: alturaController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira sua altura!";
                      } else {
                        return null;
                      }
                    }),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) _calcular();
                    },
                    child: Text(
                      "Calcular",
                      style: textStyle,
                    )),
                Text(
                  _textInfo,
                  textAlign: TextAlign.center,
                  style: textStyle,
                )
              ],
            )),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            'O que é IMC?',
            style: GoogleFonts.chicle(
                textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 40,
            )),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'O índice de massa corporal (IMC) é uma medida '
            'internacional utilizada para calcular se uma pessoa '
            'está no peso ideal.\n\n'
            'Desenvolvido por Lambert Quételet no final do séc. '
            'XIX, é um método fácil e rápido para a avaliação do '
            'nível de gordura de cada pessoa, sendo, por isso, '
            'um preditor internacional de obesidade adotado '
            'pela Organização Mundial de Saúde (OMS).',
            style: GoogleFonts.quicksand(textStyle: TextStyle(fontSize: 16)),
            textAlign: TextAlign.justify,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                'Entendido',
                style: GoogleFonts.quicksand(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
