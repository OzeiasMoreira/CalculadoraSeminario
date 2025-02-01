import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculadoraTela(),
    );
  }
}

class CalculadoraTela extends StatefulWidget {
  @override
  _CalculadoraTelaState createState() => _CalculadoraTelaState();
}

class _CalculadoraTelaState extends State<CalculadoraTela> {
  String expressao = "";
  String resultado = "";

  void calcularExpressao() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expressao);
      ContextModel cm = ContextModel();
      double res = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        resultado = res.toString();
      });
    } catch (e) {
      setState(() {
        resultado = "Erro";
      });
    }
  }

  Widget construirBotao(String texto) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
          textStyle: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          setState(() {
            if (texto == "=") {
              calcularExpressao();
            } else if (texto == "C") {
              expressao = "";
              resultado = "";
            } else {
              expressao += texto;
            }
          });
        },
        child: Text(texto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CALCULADORA TUNADA")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                expressao,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                resultado,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              construirBotao("7"),
              construirBotao("8"),
              construirBotao("9"),
              construirBotao("/"),
            ],
          ),
          Row(
            children: [
              construirBotao("4"),
              construirBotao("5"),
              construirBotao("6"),
              construirBotao("*"),
            ],
          ),
          Row(
            children: [
              construirBotao("1"),
              construirBotao("2"),
              construirBotao("3"),
              construirBotao("-"),
            ],
          ),
          Row(
            children: [
              construirBotao("0"),
              construirBotao("."),
              construirBotao("=")
            ],
          ),
          Row(
            children: [
              construirBotao("C"),
              construirBotao("+"),
              construirBotao("sin("),
              construirBotao("cos("),
            ],
          ),
          Row(
            children: [
              construirBotao("tan("),
              construirBotao("log("),
              construirBotao("exp("),
              construirBotao("^"),
            ],
          ),
        ],
      ),
    );
  }
}
