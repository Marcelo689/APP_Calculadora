// ignore_for_file: avoid_print

import 'dart:math';

import 'package:meu_app/models/separarLadosdoIgual.dart';

import 'calculo.dart';

isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

retirandoXElevado(String input) {
  String nums = "";
  List<String> xElevado = [];
  for (int i = 0; i < input.length; i++) {
    if (isNumeric(input[i]) || input[i] == "-") {
      nums += input[i];
    } else if (input[i] == "x") {
      nums += input[i];
    } else if (input[i - 1] + input[i] == "x^") {
      nums += input[i];
    } else if (input[i - 2] + input[i - 1] + input[i] == "x^" + input[i]) {
      nums += input[i];
      xElevado.add(nums);
    } else {
      nums = "";
    }
  }
  return xElevado;
}

separarLados(String input) {
  List<String> incalculavel1 = [];
  List<String> incalculavel2 = [];
  List<String> temp = [];
  int contador = 0;
  String esquerda = input.split("=")[0];
  String direita = input.split("=")[1];
  //var mapeando = temp.asMap();
  print("separar lado(esquerda)=" + esquerda);
  print("separar lado(direita)=" + direita);
  //adicionando lado esquerdo do sinal de igual para um lista de incalculaveis

  return Lados(esquerda, direita, incalculavel1, incalculavel2);
}

resolverRaizesQ(String stringCompleta) {
  List<String> operations = ["+", "-", "X", "÷", "^"];
  while (stringCompleta.indexOf("√") != -1) {
    int indiceRaiz = stringCompleta.indexOf("√");
    String conteudoDaRaiz = "";
    for (int i = indiceRaiz + 1; i < stringCompleta.length - 1; i++) {
      if (isNumeric(stringCompleta[i])) {
        conteudoDaRaiz += stringCompleta[i];
      } else {
        break;
      }
    }
    double conteudo = double.parse(conteudoDaRaiz);
    double resultado = sqrt(conteudo);
    stringCompleta.replaceAll("√" + conteudoDaRaiz, resultado.toString());
  }
}

encontrarPrioridade(String input) {
  int indice1 = input.length;
  int indice2 = input.length;
  if (input.contains("^")) {
    indice1 = input.indexOf("^");
  }
  if (input.contains("√")) {
    indice2 = input.indexOf("√");
  }
  if (indice1 != input.length || indice2 != input.length) {
    if (indice1 < indice2) {
      return indice1;
    } else {
      return indice2;
    }
  }
  if (input.contains("X")) {
    indice1 = input.indexOf("X");
  }
  if (input.contains("÷")) {
    indice2 = input.indexOf("÷");
  }
  if (indice1 != input.length || indice2 != input.length) {
    if (indice1 < indice2) {
      return indice1;
    } else {
      return indice2;
    }
  }
  if (input.contains("+")) {
    indice1 = input.indexOf("+");
  }
  if (input.contains("-")) {
    indice2 = input.indexOf("-");
  }
  if (indice1 != input.length || indice2 != input.length) {
    if (indice1 < indice2) {
      return indice1;
    } else {
      return indice2;
    }
  }
}

pegarPartePrioritaria(String input, int indice) {
  String ladoEsquerdo = "";
  for (int i = indice; i >= 0; i--) {
    if (isNumeric(input[i]) || input[i] == "-" || input[i] == "x") {
      ladoEsquerdo += input[i];
    } else {
      break;
    }
  }

  String ladoDireito = "";
  for (int i = 0; i <= input.length - 1; i++) {
    if (isNumeric(input[i]) || input[i] == "-" || input[i] == "x") {
      ladoDireito += input[i];
    } else {
      break;
    }
  }
  String sinal = input[indice];

  return Calculo(ladoEsquerdo, ladoDireito, sinal);
}

calcularTudo(String input) {
  List<String> incalculavel1 = [];
  List<String> incalculavel2 = [];
  int contador = 0;
  if (input.indexOf("=") != -1) {
    print(input);
    Lados retorno = separarLados(input);
    String esquerda = retorno.esquerdaGet;
    String direita = retorno.direitaGet;
    print("retorno esquerda" + esquerda);
    print("retorno direita" + direita);
    incalculavel1 = retorno.incalculavelEGet;
    incalculavel2 = retorno.incalculavelDGet;
    while (!isNumeric(esquerda)) {
      esquerda = calcularParte(esquerda);
      print("Lado esquerdo = " + esquerda);
    }
    while (!isNumeric(direita)) {
      direita = calcularParte(direita);
      print("Lado direito = " + direita);
    }
    input = esquerda + "=" + direita;
    return input;
  }

  while (!isNumeric(input)) {
    input = calcularParte(input);
  }
  return input;
}

parenteses(String input) {
  int parentesesE = 0;
  int parentesesD = input.length - 1;
  for (int i = 0; i < input.length; i++) {
    if (input[i] == "(") {
      parentesesE = i;
    }
  }
  for (int i = 0; i < input.length - 1; i++) {
    if (input[i] == ")") {
      parentesesD = i;
      break;
    }
  }
  print("parenteses direito = " + parentesesD.toString());
  input = input.substring(parentesesE + 1, parentesesD);
  print("saida = " + input);
  return input;
}

dividirPartes(String input) {
  String num1 = "";
  String num2 = "";
  String num3 = "";
  String sinal = "";
  print("\n" + input + "\n");
  for (int i = 0; i < input.length; i++) {
    print("\n" + input[i] + "\n");
    if ((isNumeric(input[i]) || input[i] == "-") && num1 == "") {
      num3 += input[i];
    } else if (num1 != "" && (isNumeric(input[i]) || input[i] == "-")) {
      //print("diferente de vazio");
      num3 += input[i];
      if (i == input.length - 1) {
        num2 = num3;
      }
    } else {
      if (input[i] == "^" && num1 == "") {
        num3 += "^";
      } else if (input[i] == "^" && num1 != "") {
        num3 += "^";
      } else if (input[i - 1] == "^" && num1 == "") {
        num1 = num3 + input[i];
      } else if (input[i - 1] == "^" && num1 != "") {
        num2 = num3 + input[i];
      } else if (input[i] == "x" && num1 == "") {
        num1 = num3 + "x";
      } else if (input[i] == "x" && num1 != "") {
        num2 = num3 + "x";
        //print("fez cagada");
      } else {
        if (sinal == "") {
          sinal = input[i];
        }
        if (num1 == "") {
          num1 = num3;
        } else {
          print("tentou");
          num2 = num3;
          break;
        }
        num3 = "";
      }
    }
  }
  Calculo list = new Calculo(num1, num2, sinal);
  print("Calculo \n num1=" +
      num1.toString() +
      "\n num2=" +
      num2.toString() +
      "\n sinal = " +
      sinal);
  return list;
}

calcularParte(String input) {
  String stringCompleta = input;
  String stringResultado = "";
  int numOfX = 0;
  print(input);
  print("\n");
  if (input.contains("(")) {
    input = parenteses(input);
  }
  print(input);
  print("\n");
  Calculo listInputs = (dividirPartes(input));
  String input1 = listInputs.num1Get.toString();
  String input2 = listInputs.num2Get.toString();
  String sinal = listInputs.sinal;

  if (input1 == "") {
    print("Está vazio");
    stringResultado = stringCompleta.replaceAll(stringCompleta, input);
    return stringResultado;
  }
  double num1 = double.parse(listInputs.num1Get);
  double num2 = double.parse(listInputs.num2Get);
  print("num1=" + num1.toString() + "\n num2=" + num2.toString());

  print(sinal);
  String stringCalculada = input1 + sinal + input2;
  String resultadoX = "";
  if (input1[input1.length - 1] == "x" && input2[input2.length - 1] == "x") {
    numOfX = 2;
  } else if (input1[input1.length - 1] == "x") {
    numOfX = 1;
  } else if (input2[input2.length - 1] == "x") {
    numOfX = 1;
  }
  List<double> resultados = [];
  double? resultado = 0;
  List<String> numerosPower = [];

  /// potencia
  if (input1.indexOf("^") != -1) {
    numerosPower = input1.split("^");

    resultado = pow(double.parse(numerosPower[0].toString()),
        double.parse(numerosPower[1])) as double;
    resultados.add(resultado);
    stringCompleta.replaceAll(input1, resultado.toString());
    num1 = resultado;
  }
  numerosPower = [];
  if (input2.indexOf("^") != -1) {
    numerosPower = input2.split("^");

    resultado = pow(double.parse(numerosPower[0].toString()),
        double.parse(numerosPower[1])) as double;
    resultados.add(resultado);
    stringCompleta.replaceAll(input2, resultado.toString());
    num2 = resultado;
    // valores da potencia 1 e 2
  }

  if (input2.indexOf("^") == -1 && input1.indexOf("^") == -1) {
    switch (sinal) {
      case "X":
        resultado = num1 * num2;
        print("resultado= " + resultado.toString());
        switch (numOfX) {
          case 0:
            break;
          case 1:
            resultadoX = resultado.toString() + "x";
            break;
          case 2:
            resultadoX = resultado.toString() + "x^2";
            break;
        }
        break;

      case "÷":
        resultado = num1 / num2;
        switch (numOfX) {
          case 0:
            break;
          case 1:
            resultadoX = resultado.toString() + "x";
            break;
          case 2:
            resultadoX = resultado.toString() + "x^2";
            break;
        }
        break;
      case "-":
        switch (numOfX) {
          case 0:
            resultado = num1 - num2;
            break;
          case 1:
            resultadoX = num1.toString() + sinal + num2.toString();
            break;
          case 2:
            resultado = num1 - num2;
            resultadoX = resultado.toString() + "x";
            break;
        }
        break;
      case "+":
        switch (numOfX) {
          case 0:
            resultado = num1 + num2;
            break;
          case 1:
            resultadoX = num1.toString() + sinal + num2.toString();
            break;
          case 2:
            resultado = num1 + num2;
            resultadoX = resultado.toString() + "x";
            break;
        }
        break;
      case "√":
        resultado = sqrt(num1);
        break;
    }
  }

  switch (numOfX) {
    case 0:
      break;
    case 1:
      resultadoX = resultado.toString() + "x";
      break;
    case 2:
      resultadoX = resultado.toString() + "x^2";
      break;
  }
  print("Calcular Parte \n Resultado=" +
      resultado.toString() +
      "\n resultadoX=" +
      resultadoX);
  if (resultadoX != "") {
    stringResultado = stringCompleta.replaceAll(stringCalculada, resultadoX);
  } else {
    print(stringCompleta);
    stringResultado =
        stringCompleta.replaceAll(stringCalculada, resultado.toString());
    print(stringCompleta);
  }
  return stringResultado;
}
