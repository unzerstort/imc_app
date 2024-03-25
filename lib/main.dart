// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora IMC",
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade100),
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
    return Scaffold(
        appBar: AppBar(
      title: Text('Calculadora de IMC',
          style: GoogleFonts.acme(
              textStyle: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 30))),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      leading: IconButton(
        onPressed: () => _dialogBuilder(context),
        icon: Icon(
          Icons.help_outline,
          color: Theme.of(context).secondaryHeaderColor,
        ),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: _resetCampos,
            icon: Icon(Icons.refresh,
                color: Theme.of(context).secondaryHeaderColor))
      ],
    ));
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'O que é IMC?',
            style: GoogleFonts.acme(
                textStyle: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 30)),
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
              child: const Text('Entendido'),
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
