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

existNumeroComX(String input) {
  List<String> operacoes = ["-", "X", "+", "÷"];
  String numeroComX = "";
  int indiceX = encontrarX(input);
  if (indiceX != -1) {
    numeroComX = pegarParteComX(input, indiceX);
    return numeroComX;
  } else {
    return false;
  }
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

encontrarX(String input) {
  int indice1 = input.length;
  int indice2 = input.length;

  if (input.contains("x")) {
    indice1 = input.indexOf("x");
  }

  if (indice1 != input.length) {
    return indice1;
  }

  return -1;
}

//encontra qual o primeiro a ser resolvido
encontrarIndicePrioridade(String input) {
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
  return -1;
}

pegarParteComX(String input, int indice) {
  String ladoEsquerdo = "";
  for (int i = indice - 1; i >= 0; i--) {
    if (isNumeric(input[i]) || input[i] == "-" || input[i] == ".") {
      ladoEsquerdo += input[i];
    } else {
      break;
    }
  }
  ladoEsquerdo = ladoEsquerdo.split('').reversed.join();
  String ladoDireito = "";
  for (int i = indice + 1; i <= input.length - 1; i++) {
    if (isNumeric(input[i]) || input[i] == "^" || input[i] == ".") {
      ladoDireito += input[i];
    } else {
      break;
    }
  }
  String saida = ladoEsquerdo + "x" + ladoDireito;
  return saida;
}

//pra potencia
pegarPartePrioritaria(String input, int indice) {
  print("input=" + input);
  print("119 indice=" + indice.toString());
  String ladoEsquerdo = "";
  for (int i = indice - 1; i >= 0; i--) {
    if (isNumeric(input[i]) ||
        input[i] == "-" ||
        input[i] == "x" ||
        input[i] == ".") {
      ladoEsquerdo += input[i];
    } else {
      break;
    }
  }
  ladoEsquerdo = ladoEsquerdo.split('').reversed.join();
  String ladoDireito = "";
  for (int i = indice + 1; i <= input.length - 1; i++) {
    if (isNumeric(input[i]) ||
        input[i] == "-" ||
        input[i] == "x" ||
        input[i] == ".") {
      ladoDireito += input[i];
    } else {
      break;
    }
  }
  String sinal = input[indice];
  print(" 133 lado esquerdo=" + ladoEsquerdo);
  print("lado direito =" + ladoDireito);
  print(" 135 sinal = " + sinal);
  Calculo list = new Calculo(ladoEsquerdo, ladoDireito, sinal);
  return list;
}

calcularTudo(String input) {
  List<String> incalculavel1 = [];
  List<String> incalculavel2 = [];
  List<String> operacoes = ["-", "X", "+", "÷"];
  String inputCompleto = input;
  int contador = 0;
  String temParenteses = parenteses(input);
  String tempNum = "";
  double tempDouble = 0;
  if (temParenteses != "-1") {
    input = temParenteses;
  }

  if (input.indexOf("=") != -1) {
    print(input);

    Lados retorno = separarLados(input);
    String esquerda = retorno.esquerdaGet;
    String direita = retorno.direitaGet;

    int indicePrioridade = encontrarIndicePrioridade(esquerda);
    // lado esquerdo
    print(" 171 indice prioritario = " + indicePrioridade.toString());
    if (indicePrioridade != -1) {
      Calculo CalculoPrioritario =
          pegarPartePrioritaria(esquerda, indicePrioridade);
      esquerda = calcularParteT(esquerda, CalculoPrioritario);

      print(" 169 Lado esquerdo = " + esquerda);
    }

    int indicePrioridade2 = encontrarIndicePrioridade(direita);
    if (indicePrioridade2 != -1) {
      Calculo CalculoPrioritario2 =
          pegarPartePrioritaria(direita, indicePrioridade2);
      direita = calcularParteT(direita, CalculoPrioritario2);
      print("Lado direito = " + direita);
    }
    print("Tentou mandar numero pro lado direito");
    if (esquerda == retorno.esquerdaGet) {
      if (existNumeroComX(esquerda) != false) {
        tempNum = (esquerda.replaceAll(existNumeroComX(esquerda), ""));
        if (!(tempNum == "")) {
          print("tempnum = " + tempNum);
          esquerda = esquerda.replaceAll(tempNum, "");
          String tempSinal = "";
          switch (tempNum[0]) {
            case "X":
              tempNum = tempNum.substring(1, tempNum.length);
              tempSinal = "÷";
              break;
          }
          print("antes de converter = " + tempNum);
          tempDouble = double.parse(tempNum) * -1;
          direita += tempSinal + tempDouble.toString();
        }
      }
    }
    if (esquerda.contains("x") &&
        isNumeric(esquerda.substring(0, esquerda.length - 1))) {
      if (direita.contains("x")) {
      } else {
        direita = (double.parse(direita) /
                (double.parse(esquerda.substring(0, esquerda.length - 1))))
            .toString();
        esquerda = "x";
        input = esquerda + "=" + direita;
        print(input);
        return input;
      }
    }

    input = esquerda + "=" + direita;
    print("235 tela " + input);
    return input;
  }
  print("input calcular tudo =" + input);
  while (!isNumeric(input)) {
    int indicePrioridade1 = encontrarIndicePrioridade(input);
    Calculo CalculoPrioritario1 =
        pegarPartePrioritaria(input, indicePrioridade1);

    input = calcularParteT(input, CalculoPrioritario1);
  }
  if (temParenteses != "-1") {
    input = inputCompleto.replaceAll("(" + temParenteses + ")", input);
  }
  return input;
}

parenteses(String input) {
  int parentesesE = 0;
  int parentesesD = input.length - 1;
  if (input.contains("(") && input.contains(")")) {
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
    print("201 parenteses direito = " + parentesesD.toString());
    //tirando parenteses
    input = input.substring(parentesesE + 1, parentesesD);
    print("saida = " + input);

    int indicePrioridade = encontrarIndicePrioridade(input);
    Calculo listInputs = pegarPartePrioritaria(input, indicePrioridade);
    String num1 = listInputs.num1Get;
    String num2 = listInputs.num2Get;
    String sinal = listInputs.sinal;

    String resultado = calcularParteT(input, listInputs);
    print("Resultado do parenteses =" + resultado);
    return input;
  } else {
    return "-1";
  }
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
  print("256 Calculo \n num1=" +
      num1.toString() +
      "\n num2=" +
      num2.toString() +
      "\n sinal = " +
      sinal);
  return list;
}

calcularParte(String input, Calculo listInputs) {
  String stringCompleta = input;
  String stringResultado = "";
  int numOfX = 0;
  print(input);
  print("\n");

  print(input);
  print("\n");
  //Calculo listInputs = (dividirPartes(input));
  String input1 = listInputs.num1Get.toString();
  String input2 = listInputs.num2Get.toString();
  String sinal = listInputs.sinal;

  String incalculavel = "";
  print(listInputs.num1Get);
  if (input1 == "") {
    print("Está vazio");
    stringResultado = stringCompleta.replaceAll(stringCompleta, input);
    return stringResultado;
  }
  if (isNumeric(input1) == false) {
    print("caiu na armadilha 1");
    return stringCompleta;
  }

  if (isNumeric(input2) == false) {
    print("caiu na armadilha");
    return stringCompleta;
  }
  double num1 = double.parse(listInputs.num1Get);
  double num2 = double.parse(listInputs.num2Get);
  print("289 num1=" + num1.toString() + "\n num2=" + num2.toString());

  print(sinal);
  String stringCalculada = input1 + sinal + input2;
  String resultadoX = "";
  if (input1[input1.length - 1] == "x" && input2[input2.length - 1] == "x") {
    numOfX = 2;
  } else if (input1[input1.length - 1] == "x") {
    incalculavel = input1;
    numOfX = 1;
  } else if (input2[input2.length - 1] == "x") {
    incalculavel = input2;
    numOfX = 1;
  } else {
    numOfX = 0;
  }
  List<double> resultados = [];
  double? resultado = 0;
  List<String> numerosPower = [];

  /// potencia

  numerosPower = [];
  if (incalculavel != "") {}
  switch (sinal) {
    case "^":
      resultado = pow(num1, num2) as double;
      print("331 resultado= " + resultado.toString());
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
    case "X":
      resultado = num1 * num2;
      print("331 resultado= " + resultado.toString());
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

calcularParteT(String input, Calculo listInputs) {
  String stringCompleta = input;
  String stringResultado = "";
  int numOfX = 0;
  print(input);
  print("\n");

  print(input);
  print("\n");
  //Calculo listInputs = (dividirPartes(input));
  String input1 = listInputs.num1Get.toString();
  String input2 = listInputs.num2Get.toString();
  String sinal = listInputs.sinal;
  double num2 = 0;
  double num1 = 0;
  String incalculavel = "";
  print(listInputs.num1Get);
  if (input1 == "" || input2 == "") {
    print("Está vazio");
    stringResultado = stringCompleta.replaceAll(stringCompleta, input);
    return stringResultado;
  }
  if (!isNumeric(input1) == false) {
    num1 = double.parse(listInputs.num1Get);
  }

  if (!isNumeric(input2) == false) {
    num2 = double.parse(listInputs.num2Get);
  }
  print("289 num1=" + num1.toString() + "\n num2=" + num2.toString());

  print(sinal);
  String stringCalculada = input1 + sinal + input2;
  String resultadoX = "";
  if (input1[input1.length - 1] == "x" && input2[input2.length - 1] == "x") {
    numOfX = 3;
    print("num1 input1 = " + input1.substring(0, input1.length - 1));
    num1 = double.parse(input1.substring(0, input1.length - 1));
    num2 = double.parse(input2.substring(0, input2.length - 1));
  } else if (input1[input1.length - 1] == "x") {
    print("num1 input1 = " + input1.substring(0, input1.length - 1));
    num1 = double.parse(input1.substring(0, input1.length - 1));
    numOfX = 1;
  } else if (input2[input2.length - 1] == "x") {
    print("num1 input1 = " + input2.substring(0, input2.length - 1));
    num2 = double.parse(input2.substring(0, input2.length - 1));
    numOfX = 2;
  } else {
    numOfX = 0;
  }
  List<double> resultados = [];
  double? resultado = 0;
  List<String> numerosPower = [];

  /// potencia

  numerosPower = [];
  switch (sinal) {
    case "^":
      resultado = pow(num1, num2) as double;
      print("331 resultado= " + resultado.toString());
      switch (numOfX) {
        case 0:
          break;
        case 1:
          resultadoX = resultado.toString() + "x";
          break;
        case 2:
          resultadoX = resultado.toString() + "x";
          break;
        case 3:
          resultadoX = resultado.toString() + "x^2";
          break;
      }
      break;
    case "X":
      resultado = num1 * num2;
      print("331 resultado= " + resultado.toString());
      switch (numOfX) {
        case 0:
          break;
        case 1:
          resultadoX = resultado.toString() + "x";
          break;
        case 2:
          resultadoX = resultado.toString() + "x";
          break;
        case 3:
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
          resultadoX = resultado.toString() + "x";
          break;
        case 3:
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
          resultadoX = resultado.toString() + "x";
          break;
        case 2:
          resultadoX = resultado.toString() + "x";
          break;
        case 3:
          resultadoX = resultado.toString() + "x^2";
          break;
      }
      break;
    case "+":
      switch (numOfX) {
        case 0:
          resultado = num1 + num2;
          break;
        case 1:
          resultadoX = resultado.toString() + "x";
          break;
        case 2:
          resultadoX = resultado.toString() + "x";
          break;
        case 3:
          resultadoX = resultado.toString() + "x^2";
          break;
      }
      break;
    case "√":
      resultado = sqrt(num1);
      break;
  }

  switch (numOfX) {
    case 0:
      break;
    case 1:
      resultadoX = resultado.toString() + "x";
      break;
    case 2:
      resultadoX = resultado.toString() + "x";
      break;
    case 3:
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
