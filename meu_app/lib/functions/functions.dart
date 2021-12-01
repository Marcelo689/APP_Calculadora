isNumeric(String s){
  if(s == null){
    return false;
  }
  return double.tryParse(s) != null;
}

pegarNumeros(String input){
  List<String> nums  =input.split("_");
  return nums;
}
calcular(String input){
  input = parenteses(input);
  List<String> listCalc = efetuarCalculo(input);
  double num1 = double.parse(listCalc[0]);
  double num2 = double.parse(listCalc[1]);
  String sinal = listCalc[2];

  switch(sinal){
    case "X":
      return num1*num2;
      break;
  }
}
parenteses(String input){
  int parentesesE = 0;
  int parentesesD = input.length-1;
  for(int i=0 ; i< input.length;i++){
    if(input[i] == "(")
    {
      parentesesE = i;
    }
  }
  for(int i=0 ; i< input.length;i++){
    if(input[i] == ")")
    {
      parentesesD = i;
      break;
    }
  }
  input = input.substring(parentesesE,parentesesD);
  return input;
}
efetuarCalculo(String input){
  String num1 ="";
  String num2 ="";
  String num3 ="";
  String sinal ="";
  for(int i=0;i< input.length; i++){
    if(isNumeric(input[i]) && num1 == ""){
      num3 += input[i];
    }else if(num1 != "" && isNumeric(input[i])){
      num3 += input[i];
    }
    else{
      if(num1 != ""){
        num2 = num3;
      }else{
        sinal = input[i];
        num1 = num3;
      }
      num3 = "";
      
    }
    if(input[i] == "X"){
      input.replaceRange(i,i,"_");
      return i;
    }

    return [num1,num2,sinal];
  }
  return -1;
} 
removerDivisao(String input){
  for(int i=0;i< input.length; i++){
    if(input[i] == "÷"){
      input.replaceRange(i,i,"_");
      return i;
    }
  }
  return -1;
}