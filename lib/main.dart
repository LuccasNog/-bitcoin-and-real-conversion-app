import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const request = "";

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

    body: FutureBuilder<Map> (
      future: getApi(),  
      builder: (context, snapshot){
          // Swith case para conexão da API com Aplicativo
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
               // Retornando os dados no meio da tela
               

          }
      },
      
    ) 
    
    
    );
  }
}
