import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = "Informe seus dados de pessoa curiosa que quer saber sobre sua saúde!";

  //chave para validar os textfields
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _imc() {
    double weight = double.parse((weightController.text));
    double height = double.parse(heightController.text) / 100;


    double imc = weight / (height * height);
    setState(() {
      if (imc < 18.6) {
        _infoText = "Vc ta magricela de mais! Vai comer uma lata de leite condensado "
            "com Nescau para engordar essas canelas de pardal! (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Ta bom! Não vai fazer merda! (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Ta precisando criar um pouco de vergonha na cara e comer menos! "
            "(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Ta bem porpeta hein? Segura essa boca! (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "O baleia! Para de gastar com comida e vai correr que ajuda "
            "a economiza dinheiro e emagrecer! (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Ja compra um caixão! Mas compra um daqueles bem grandes! "
            "Sem miséria na comida, sem miséria no caixão! (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados:";
      _formKey = GlobalKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey, //chave para validar campos vazios
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                validator: (value){
                  if(value.isEmpty){
                    return "Informe seu peso";
                  };
                },
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 20.0,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
              ),
              TextFormField(
                controller: heightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Informe sua altura";
                  };
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 20.0,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _imc();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.00,
                      ),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
