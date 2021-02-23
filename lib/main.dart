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
    @override
    Widget build(BuildContext context) {

      return Scaffold(

      backgroundColor: Colors.blueGrey[50],
          appBar: AppBar(
          title: Text("Converta seus Bitcoins ", style: TextStyle(fontFamily: 'Raleway-Regular.tff', color: Colors.grey[900], fontSize: 25.0), ),
          backgroundColor: Colors.blueGrey[50],
          centerTitle: true,
          elevation: 0,
        ),

        body: Center(
          child: Text("Vamos converter Bitcoins em Reais"),
             
          ),
      );
    }
  }