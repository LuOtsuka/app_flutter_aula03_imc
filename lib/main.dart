import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Imc(),
  ));
}

class Imc extends StatefulWidget {
  @override
  _ImcState createState() => _ImcState();
}

class _ImcState extends State<Imc> {

  String resultado = "IMC: ";
  TextEditingController txtNome   = TextEditingController();
  TextEditingController txtPeso   = TextEditingController();
  TextEditingController txtAltura = TextEditingController();
  GlobalKey<FormState> cForm = GlobalKey<FormState>();

  Function validaPeso = ((value){
    if(value.isEmpty){
      return "Informe o Peso";
    }
    if(int.parse(value) <=0){
      return "O peso não deve ser zero ou negativo";
    }
    return null;
  });

  Function validaAltura = ((value){
    if(value.isEmpty){
      return "Informe a Altura";
    }
    if(double.parse(value) <=0){
      return "A altura não deve ser zero ou negativo";
    }
    return null;
  });

  calculaImc(){

    if(!cForm.currentState.validate())
      return null;

    double peso = double.parse(txtPeso.text);
    double altura = double.parse(txtAltura.text);
    double imc = peso / (altura * altura);
    setState(() {
      if(imc < 18.5)
        resultado = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      else
      if(imc >= 18.5 && imc < 30)
        resultado = "Peso ideal (${imc.toStringAsPrecision(4)})";
      else
        resultado = "Acima do peso (${imc.toStringAsPrecision(4)})";
    });
    print(resultado);
  }

  resetaTela(){
    txtNome.text = "";
    txtAltura.text = "";
    txtPeso.text = "";
    setState(() {
      resultado = "IMC:";
      cForm = GlobalKey<FormState>();
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC T4"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetaTela,
          ),
        ],
      ),
      body: telaPrincipal(),
    );
  }

  telaPrincipal() {
    return Form(
      key: cForm,
      child: SingleChildScrollView(
        child: Column(
          children: [
            caixaDeTexto("Nome", "Digite seu nome", txtNome, null ),
            caixaDeTexto("Peso", "Digite seu peso", txtPeso, validaPeso, numero: true),
            caixaDeTexto("Altura", "Digite sua altura", txtAltura, validaAltura, numero: true),
            botao("Calcular", calculaImc),
            Text(resultado, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }

static caixaDeTexto(String rotulo, String dica,
      TextEditingController controlador, valicao,
      {bool obscure=false, bool numero=false}){
    return TextFormField(
      controller: controlador,
      obscureText: obscure,
      validator: valicao,
      keyboardType: numero?TextInputType.number:TextInputType.text,
      decoration: InputDecoration(
        labelText: rotulo,
        labelStyle:TextStyle(fontSize: 18),
        hintText: dica,
        hintStyle:TextStyle(fontSize: 10, color: Colors.red),
      ),
    );
  }

  static botao(String _texto, Function _f){
    return Container(
      child: RaisedButton(
        onPressed: _f,
        child: Text(
          _texto,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black, width: 4)
        ),
        color: Colors.black87.withOpacity(0.4),
        hoverColor: Colors.yellow.withOpacity(0.3),
      ),
    );

  }

}