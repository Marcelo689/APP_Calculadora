class Calculo {
  String num1 = "";
  String num2 = "";
  String sinal = "";
  Calculo(num1, num2, sinal) {
    this.num1 = num1;
    this.num2 = num2;
    this.sinal = sinal;
  }
  String get num1Get {
    return this.num1;
  }

  String get num2Get => this.num2;

  String get sinalGet => this.sinal;
}
