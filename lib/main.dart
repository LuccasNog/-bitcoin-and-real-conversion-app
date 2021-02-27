import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
//import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'dart:convert';
import 'dart:ui';
//import 'package:crypto_font_icons/crypto_font_icons.dart';

const request = "https://api.hgbrasil.com/finance?key=8f7b493a";

void main() {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.black,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          hintStyle: TextStyle(color: Colors.purple[50]),
        )),
  ));
}

// Vai retornar os dados da API no futuro
Future<Map> getApi() async {
  // Fazendo requisição assinrona
  http.Response response = await http.get(request);
  // Para chamar o JSON devemos importar a biblioteca convert
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Criando as funçãos que vai converter Bitcoin em Reais
  final realController = TextEditingController();
  final bitcoinController = TextEditingController();
  final dolarController = TextEditingController();
  // Criando as funções de conversão
  void _brlChanges(String text) {
    // Convertendo o BRL em texto
    double real = double.parse(text);
    print(" O valor do real é $real");
    // Convertendo para dolar e euro e mostrar duas casas decimais
    dolarController.text = (dolar * real).toStringAsFixed(4);
    bitcoinController.text = (dolar * bitcoin).toStringAsFixed(4);
  }

  void _dolarChanges(String text) {
    // Convertendo o BRL em texto
    double dolar = double.parse(text);
   print(" O valor do dolar é $dolar");
    // Convertendo para dolar e euro e mostrar duas casas decimais
   realController.text = (dolar * this.dolar).toStringAsFixed(4);
   bitcoinController.text = (bitcoin * dolar).toStringAsFixed(4);
  }

  void _bitcoinChanges(String text) {
    // Convertendo o BRL em texto
    double bitcoin = double.parse(text);
    print(" O valor do bitcoin é $bitcoin");
    // Convertendo para dolar e euro e mostrar duas casas decimais
    realController.text = (bitcoin * dolar).toStringAsFixed(4);
    dolarController.text = (dolar * bitcoin).toStringAsFixed(2);
  }

  // declarando a variavel dolar
  double dolar;

  double bitcoin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], //Colors.blueGrey[50]
      appBar: AppBar(
        title: Text(
          "Converta Reais em Dolares ",
          style: TextStyle(
              fontFamily: 'Raleway-Regular.tff',
              color: Colors.purple[50],
              fontSize: 25.0),
        ),
        backgroundColor: Colors.amber, // Colors.grey[900] Colors.blueGrey[50]
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<Map>(
          // Futuro que o builder vai construir
          // COnstruir a tela de acordo com os dados que estão carregados
          future: getApi(),
          // context =  contexto e snapshot  = copia dos dados do servidor
          builder: (context, snapshot) {
            // Utilizando o Swith para ver o estado da requisição
            switch (snapshot.connectionState) {
              // se o status da conexão que não está conectando em nada
              case ConnectionState.none:
              // Se o status estiver esperando os dados
              case ConnectionState.waiting:
                return Center(
                  // Colocando como filho um texto
                  child: Text(
                    "Carregando Dados....",
                    style: TextStyle(color: Colors.amber),
                    textAlign: TextAlign.center,
                  ),
                );
              // colocando o default caso ele não esteja esperando e nem parado

              default:
                if (snapshot.hasError) {
                  return Center(
                    // Colocando como filho um texto
                    child: Text(
                      "Error ao carregar dados....",
                      style: TextStyle(color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  // Peghando o valor da variavel dolar que está no servidor
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  bitcoin = snapshot.data["results"]["currencies"]["BTC"]["buy"];
                  //bitcoin = snapshot.data["results"]["currencies"]["BTC"]["buy"]; 
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on,
                          size: 50.0,
                          color: Colors.amber,
                        ),
                        Divider(),
                        Text(
                          "Fácil e Rápido",
                          style: TextStyle(
                              fontFamily: 'Raleway-Italic.ttf',
                              color: Colors.amber,
                              fontSize: 20.0),
                        ),
                        createTextField(
                            "Reais", "R\$: ", realController, _brlChanges),
                        Divider(),
                        createTextField(
                            "Dolares", "R\$: ", dolarController, _dolarChanges),
                        Divider(),
                        createTextField("Bitcoin", "฿: ", bitcoinController,
                            _bitcoinChanges),
                        Divider(),
                        ButtonTheme(
                          height: 50,
                          child: RaisedButton(
                            onPressed: () => {print("Conversão feita")},
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(80)),
                            child: Text(
                              "Converter",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 20),
                            ),
                            color: Colors.amber,
                          ),
                        )
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

// Criando um Widget que vai retornar um campo de texto
Widget createTextField(
    String label, String prefix, TextEditingController control, Function f) {
  return TextField(
    controller: control,
    // Definindo decoração do input
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber, fontSize: 20.0),
    onChanged: f,
  );
}
