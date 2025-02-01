import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';  // Necessário para capturar eventos do teclado

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

  // Função para calcular a expressão
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

  // Função para adicionar caracteres na expressão
  void adicionarCaracter(String char) {
    setState(() {
      if (char == "=") {
        calcularExpressao();
      } else if (char == "C") {
        expressao = "";
        resultado = "";
      } else {
        expressao += char;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (event.runtimeType == RawKeyDownEvent) { // Verifica o tipo de evento
          String key = event.logicalKey.keyLabel;

          // Tratar diferentes teclas pressionadas
          if (key == "Enter") {
            calcularExpressao();
          } else if (key == "Backspace" && expressao.isNotEmpty) {
            setState(() {
              expressao = expressao.substring(0, expressao.length - 1);
            });
          } else if ("0123456789+-*/().".contains(key)) {
            adicionarCaracter(key);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Calculadora Avançada")),
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
                construirBotao("="),
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
      ),
    );
  }

  // Função para construir os botões da calculadora
  Widget construirBotao(String texto) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
          textStyle: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          adicionarCaracter(texto);
        },
        child: Text(texto),
      ),
    );
  }
}
