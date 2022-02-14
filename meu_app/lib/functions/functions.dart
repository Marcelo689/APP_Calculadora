// ignore_for_file: avoid_print

import 'dart:math';

import 'package:meu_app/models/separarLadosdoIgual.dart';

import 'calculo.dart';
import 'incalculavel.dart';

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
  print("indice ao procurar x "+indiceX.toString());
  if (indiceX != -1) {
    numeroComX = pegarParteComX(input, indiceX);
    print("numero com x resultado   "+numeroComX);

    if(input.indexOf(numeroComX) != -1){
      return numeroComX;
    }else{
      numeroComX = removeOneLetter(numeroComX, 0);
      return numeroComX;
    }

  } else {
    return false;
  }
}
IsBaskara(String input){
  if(input.contains("x^2")){
    input = input.replaceAll("x^2", "");
    if(input.contains("x")){
      return true;
    }
  }
  return false;

}
resolverBaskara(String input){
 pegarPartePrioritaria(input, indice)
  if(IsBaskara(input)) {
    double a = pegarParteComXQuadrado(input, indice);
    double b = pegarParteComX(input, indice);
    double c = pegarParteComXQuadrado(input, indice);
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

  if (input.contains("x")) {
    indice1 = input.indexOf("x");
  }

  if (indice1 != input.length) {
    return indice1;
  }

  return -1;
}

removeOneLetter(String input, int indice) {
  String saida = "";
  for (int i = 0; i < input.length; i++) {
    if (!(i == indice)) {
      saida += input[i];
    }
  }
  return saida;
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
      return indice1 ;
    } else {
      return indice2 ;
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
      return indice1 ;
    } else {
      return indice2 ;
    }
  }
  if (input.contains("+")) {
    indice1 = input.indexOf("+", 1);
    print("119 input1 indice1 = " + indice1.toString());
  }
  if (input.contains("-", 1)) {
    indice2 = input.indexOf("-", 1);
  }
  if (indice1 != input.length || indice2 != input.length) {
    if (indice1 < indice2) {
      return indice1 ;
    } else {
      return indice2 ;
    }
  }

  return -1;
}

pegarParteComX(String input, int indice) {
  List<String> operations = ["+", "-", "X", "÷", "^"];
  String ladoEsquerdo = "";
  String sinal = "";
  print("pegarParteComX input :" +input);
  for (int i = indice - 1; i >= 0; i--) {
    print("for pegarParte :"+input[i]);
    if (isNumeric(input[i]) || input[i] == "-" || input[i] == ".") {

      ladoEsquerdo += input[i];
      if(operations.contains(input[i])){
        break;
      }
      print("lado esquerdo atual :"+ladoEsquerdo);
    } else {
      break;
    }
  }
  ladoEsquerdo = ladoEsquerdo.split('').reversed.join();
  print("lado esquerdo do x pegarParte :"+ladoEsquerdo);
  String ladoDireito = "";
  for (int i = indice + 1; i <= input.length - 1; i++) {
    if (isNumeric(input[i]) || input[i] == "^" || input[i] == ".") {
      ladoDireito += input[i];
    } else {
      break;
    }
  }
  print("primeiro indice "+ladoEsquerdo[0]);
  ladoEsquerdo = addSinal(ladoEsquerdo);

  String saida = ladoEsquerdo + "x" + ladoDireito;
  print("saida do conteudo x = "+saida);
  return saida;
}
PegarEsquerdaSinal(String input, int indice) {
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
    ladoEsquerdo = ladoEsquerdo
        .split('')
        .reversed
        .join();
    return ladoEsquerdo;
  }
}
  PegarDireitoSinal(String input, int indice) {
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
      return ladoDireito;
    }
  }

//pra potencia
pegarPartePrioritaria(String input, int indice) {
  String ladoEsquerdo = "";
  String ladoDireito = "";
  String sinal = input[indice];
  String StringCalculada="";
  Calculo list= new Calculo(ladoEsquerdo, ladoDireito, sinal);
  if(sinal == "√"){
    ladoEsquerdo = input.substring(indice+1,input.length);
    StringCalculada = sinal + ladoEsquerdo;
  }else if(sinal == "^")
  {
    if(input[indice-1] == "x" && input[indice+1] == "2"){

      ladoEsquerdo = PegarEsquerdaSinal(input, indice);
      ladoDireito = PegarDireitoSinal(input, indice);
      list = new Calculo(ladoEsquerdo, ladoDireito, sinal);
      list.StringCalculada = (ladoEsquerdo + sinal + ladoDireito);
      return list;
    }
  }
  else
  {
    ladoEsquerdo = PegarEsquerdaSinal(input, indice);
    ladoDireito = PegarDireitoSinal(input, indice);

    StringCalculada= ladoEsquerdo + sinal + ladoDireito;
  }
  print(" 133 lado esquerdo=" + ladoEsquerdo);
  print("lado direito =" + ladoDireito);
  print(" 135 sinal = " + sinal);
  list = new Calculo(ladoEsquerdo, ladoDireito, sinal);
  list.StringCalculada = StringCalculada;
  return list;
}
addSinal(String input){
  if(input[0] == "+" || input[0] == "-"){
    return input;
  }
  String saida = "+"+input;
  return saida;
}
removeSinal(String input){
  String saida = "";
  if(input[0] == "+" || input[0] == "-"){
    saida =removeOneLetter(input, 0);
    return saida;
  }else{
    return input;
  }

}
alterarSinal(String entrada){
  String sinal = "";
  entrada = addSinal(entrada);
  sinal = entrada[0];
  if(sinal == "+")
  {
    sinal = "-";
  }else{
    sinal = "+";
  }

  return sinal+removeOneLetter(entrada, 0);

}
calcularTudo(String input) {
  List<String> incalculaveis = [];
  String inputCompleto = input;
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
    String tempCalculo="";
    String apenasNumerosCalculados="";
    int indicePrioridade = -1;
    String numeroComX = "";
    Calculo CalculoPrioritario= new Calculo("", "", "");
    //futuramente while
    while(existNumeroComX(direita) != false){
      numeroComX = existNumeroComX(direita);
      print("lado direito numero com x :   "+numeroComX);
      print("numero com x depois de alterar sinal :"+alterarSinal(numeroComX));
      incalculaveis.add(alterarSinal(numeroComX));
      numeroComX = addSinal(numeroComX);
      if(direita.indexOf(numeroComX) != -1 ){
        direita = direita.replaceAll(numeroComX, "");
        print("depois do replace lado direito x :"+direita);
      }else{
        numeroComX = removeOneLetter(numeroComX, 0);
        direita = direita.replaceAll(numeroComX, "");
      }
      print("Esquerda depois : "+direita);
      if(esquerda.isEmpty){
        break;
      }
    }
    while(existNumeroComX(esquerda) != false){
      numeroComX = existNumeroComX(esquerda);
      print("numero com X 243 :   "+numeroComX);
      incalculaveis.add(numeroComX);
      numeroComX = addSinal(numeroComX);
      if(esquerda.indexOf(numeroComX) != -1 ){
        esquerda = esquerda.replaceAll(numeroComX, "");
        print("encontrou sinal do x");
      }else{
        numeroComX = removeOneLetter(numeroComX, 0);
        esquerda = esquerda.replaceAll(numeroComX, "");
      }
      print("Esquerda depois : "+esquerda);
      if(esquerda.isEmpty){
        break;
      }
    }
    if(esquerda.isNotEmpty) {
      indicePrioridade = encontrarIndicePrioridade(esquerda);
      print("indice erro = " + indicePrioridade.toString());

      if (indicePrioridade != -1) {
        CalculoPrioritario = pegarPartePrioritaria(
            esquerda, indicePrioridade);
        if(CalculoPrioritario.sinal == "X" && CalculoPrioritario.num1 == ""){

          esquerda ="";
          while (incalculaveis.isNotEmpty) {
            esquerda += incalculaveis.first;
            incalculaveis.removeAt(0);
          }
          esquerda+= CalculoPrioritario.sinal+CalculoPrioritario.num2;
          print("Esquerda 292  "+esquerda);
        }

        CalculoPrioritario = pegarPartePrioritaria(
            esquerda, indicePrioridade);
        tempCalculo = calcularParteT(esquerda, CalculoPrioritario);
        esquerda = "";
        tempCalculo = addSinal(tempCalculo);
        print("Resultado do temp  " + tempCalculo);
        while (incalculaveis.isNotEmpty) {
          esquerda += incalculaveis.first;
          incalculaveis.removeAt(0);
        }
        print("String calculada " + esquerda);
        esquerda += tempCalculo;
      } else {
        print("sinal " + esquerda);
        String sinal = esquerda[0];
        if(sinal == "+"){
          sinal = "-";
        }else{
          sinal  = "+";
        }
        direita += sinal+(double.parse(esquerda) * -1).toString();
        esquerda = esquerda.replaceAll(esquerda, "");
        print("esquerda 269  " + esquerda);
        print("lado direito 288 :  "+direita);
        while (incalculaveis.isNotEmpty) {
            esquerda += addSinal(incalculaveis.first);
          incalculaveis.removeAt(0);
        }
      }
    }
    while(incalculaveis.isNotEmpty){
      esquerda += addSinal(incalculaveis.first);
      incalculaveis.removeAt(0);
    }

    print("esquerda finalizada "+esquerda);

    indicePrioridade =encontrarIndicePrioridade(esquerda);
    if(indicePrioridade != -1) {
      CalculoPrioritario = pegarPartePrioritaria(esquerda, indicePrioridade);
      esquerda = calcularParteT(esquerda, CalculoPrioritario);
      // Calculou a esquerda
      // lado esquerdo
      print(" 171 restante da esquerda = " + esquerda);
    }
    int indicePrioridade2 = encontrarIndicePrioridade(direita);
    if (indicePrioridade2 != -1) {
      Calculo CalculoPrioritario2 =
          pegarPartePrioritaria(direita, indicePrioridade2);
      direita = calcularParteT(direita, CalculoPrioritario2);
      print("Lado direito = " + direita);
    }
    print("Tentou mandar numero pro lado direito"+esquerda);
    print("retorno esquerda "+retorno.esquerda);
    if (esquerda == retorno.esquerdaGet) {
      if (existNumeroComX(esquerda) != false) {
        print("tempnum = " + tempNum);
        tempNum = (esquerda.replaceAll(existNumeroComX(esquerda), ""));
        print("tempnum = " + tempNum);
        if (tempNum[0] == "+") {
          tempNum = removeOneLetter(tempNum, 0);
        }
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
        print("esquerda (direita)  "+esquerda);
        if (!esquerda.contains("x^2")) {
          direita = (double.parse(direita) /
              (double.parse(esquerda.substring(0, esquerda.length - 1))))
              .toString();
          esquerda = "x";
          input = esquerda + "=" + direita;
          print(input);
          return input;
        }
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

// fazer 2x+3+3 = 30 ser resolvido pois os numeros do lado esquerdo não vão para o direito corretamente
calcularParteT(String input, Calculo listInputs) {
  String stringCompleta = input;
  String stringResultado = "";
  String stringCalculada= "";
  int numOfX = 0;
  print(input);
  print("\n");

  print(input);
  print("\n");
  String input1 = listInputs.num1Get.toString();
  String input2 = listInputs.num2Get.toString();
  String sinal = listInputs.sinal;
  double num2 = 0;
  double num1 = 0;
  String incalculavel = "";
  print("calcular tudo \n input1 = " + input1);
  print(listInputs.num1Get);
  if(sinal == "√"){
    stringCalculada = sinal + input1;
  }else
  if (input1 == "" || input2 == "") {
    print("Está vazio");
    stringResultado = stringCompleta.replaceAll(stringCompleta, input);
    return stringResultado;
  }

  if (isNumeric(input1)) {
    num1 = double.parse(listInputs.num1Get);
  }

  if (isNumeric(input2)) {
    num2 = double.parse(listInputs.num2Get);
  }
  print("289 num1=" + num1.toString() + "\n num2=" + num2.toString());

  print(sinal);
  String resultadoX = "";
  if(!(sinal == "√")) {
    if (input1[input1.length - 1] == "x" && input2[input2.length - 1] == "x") {
      numOfX = 3;
      print(
          "num1 input1 and input 2 = " +
              input1.substring(0, input1.length - 1));
      num1 = double.parse(input1.substring(0, input1.length - 1));
      num2 = double.parse(input2.substring(0, input2.length - 1));

      print("numero um  " + num1.toString());
      print("numero dois  " + num2.toString());
    } else if (input1[input1.length - 1] == "x") {
      print("num1 input1 = " + input1.substring(0, input1.length - 1));
      num1 = double.parse(input1.substring(0, input1.length - 1));
      numOfX = 1;
    } else if (input2[input2.length - 1] == "x") {
      print("num2 input2 = " + input2.substring(0, input2.length - 1));
      num2 = double.parse(input2.substring(0, input2.length - 1));
      numOfX = 2;
    } else {
      numOfX = 0;
    }
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
          resultadoX = resultado.toString() + "x^"+num2.toString();
          break;
        case 2:
          resultadoX = resultado.toString() + "x^"+num2.toString();
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
          num2 = double.parse(removeSinal(num2.toString()));
          resultado = num1 -num2;
          print("resultado subtração   " +resultado.toString() );
          break;
        case 1:
          return input;
          //incalculavel
          break;
        case 2:
          return input;
          //incalculavel
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
          return input;
          // incalculavel
        case 2:
          return input;
          // incalculavel

        case 3:
          resultado = num1 + num2;
          resultadoX = resultado.toString() + "x";
          break;
      }
      break;
    case "√":
      resultado = sqrt(num1);
      break;
  }
  if(!(sinal == "√")){
    stringCalculada = input1 + sinal + input2;
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
