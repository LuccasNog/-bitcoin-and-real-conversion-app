import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';

const request = "https://api.hgbrasil.com/finance?key=8f7b493a";

void main() {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text(
          "Converta seus Bitcoins ",
          style: TextStyle(
              fontFamily: 'Raleway-Regular.tff',
              color: Colors.grey[900],
              fontSize: 25.0),
        ),
        backgroundColor: Colors.blueGrey[50],
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
                      style: TextStyle(color: Colors.amber),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  // Pegando os dados e colocando na tela
                  return Container(
                    color: Colors.blueGrey[50],
                  );
                }
            }
          }),
    );
  }
}

// Criando um Widget que vai retornar um campo de texto
Widget createTextField(String label, String prefix, TextEditingController control, Function f){



}