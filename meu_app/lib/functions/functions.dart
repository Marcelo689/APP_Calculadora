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
}

separarLados(String input) {
  List<String> incalculavel1 = [];
  List<String> incalculavel2 = [];
  List<String> temp = [];
  int contador = 0;
  if (input.indexOf("=") != -1) {
    String esquerda = input.split("=")[0];
    String direita = input.split("=")[1];
    temp = retirandoXElevado(esquerda);
    var mapeando = temp.asMap();

    //adicionando lado esquerdo do sinal de igual para um lista de incalculaveis
    while (mapeando.length > contador) {
      incalculavel1.add(mapeando[contador].toString());
      esquerda.replaceAll(mapeando[contador].toString(), "");
    }
    contador = 0;
    mapeando.clear();
    List<String> temp1 = retirandoXElevado(direita);
    mapeando = temp1.asMap();

    //adicionando lado direito do igual dos incalculaveis x^2
    while (mapeando.length > contador) {
      incalculavel2.add(mapeando[contador].toString());
      direita.replaceAll(mapeando[contador].toString(), "");
    }

    return [esquerda, direita, incalculavel1, incalculavel2];
  }
}

calcularTudo(String input) {
  List<String> incalculavel1 = [];
  List<String> incalculavel2 = [];
  List<String> temp = [];
  int contador = 0;
  if (input.indexOf("=") != -1) {
    String esquerda = input.split("=")[0];
    String direita = input.split("=")[1];
    temp = retirandoXElevado(esquerda);
    var mapeando = temp.asMap();

    //adicionando lado esquerdo do sinal de igual para um lista de incalculaveis
    while (mapeando.length > contador) {
      incalculavel1.add(mapeando[contador].toString());
      esquerda.replaceAll(mapeando[contador].toString(), "");
    }
    contador = 0;
    mapeando.clear();
    List<String> temp1 = retirandoXElevado(direita);
    mapeando = temp1.asMap();

    //adicionando lado direito do igual dos incalculaveis x^2
    while (mapeando.length > contador) {
      incalculavel2.add(mapeando[contador].toString());
      direita.replaceAll(mapeando[contador].toString(), "");
    }

    while (!isNumeric(esquerda)) {
      esquerda = calcularParte(esquerda);
    }
    while (!isNumeric(direita)) {
      direita = calcularParte(direita);
    }
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
  for (int i = 0; i < input.length; i++) {
    if (input[i] == ")") {
      parentesesD = i;
      break;
    }
  }
  input = input.substring(parentesesE, parentesesD);
  return input;
}

efetuarCalculo(String input) {
  String num1 = "";
  String num2 = "";
  String num3 = "";
  String sinal = "";
  for (int i = 0; i < input.length; i++) {
    if ((isNumeric(input[i]) || input[i] == "-") && num1 == "") {
      num3 += input[i];
    } else if (num1 != "" && (isNumeric(input[i]) || input[i] == "-")) {
      num3 += input[i];
    } else {
      if (input[i] == "²") {
        num1 = "0";
      }
      if (input[i] == "x" && num1 == "") {
        num1 = num3 + "x";
      } else if (input[i] == "x" && num1 != "") {
        num2 = num3 + "x";
      } else if (num1 != "") {
        num2 = num3;
      } else {
        sinal = input[i];
        num1 = num3;
      }
      num3 = "";
    }
  }
  Calculo list = new Calculo(num1, num2, sinal);

  return list;
}

calcularParte(String input) {
  String stringCompleta = input;
  int numOfX = 0;
  input = parenteses(input);
  Calculo listInputs = (efetuarCalculo(input));
  double num1 = (listInputs.num1Get);
  double num2 = (listInputs.num2Get);

  String input1 = listInputs.num1Get.toString();
  String input2 = listInputs.num2Get.toString();
  if (input1[input1.length - 1] == "x" && input2[input2.length - 1] == "x") {
    numOfX = 2;
  } else if (input1[input1.length - 1] == "x") {
    numOfX = 1;
  } else if (input2[input2.length - 1] == "x") {
    numOfX = 1;
  }
  String sinal = listInputs.sinal;
  String stringCalculada = input1 + sinal + input2;

  double resultado = 0;
  String resultadoX = "";
  switch (sinal) {
    case "X":
      resultado = num1 * num2;
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
  if (resultadoX != "") {
    stringCompleta.replaceAll(stringCalculada, resultadoX);
  } else {
    stringCompleta.replaceAll(stringCalculada, resultado.toString());
  }
  return stringCompleta;
}
