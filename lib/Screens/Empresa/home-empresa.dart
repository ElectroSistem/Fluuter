import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeEmpresa extends StatefulWidget {
  const HomeEmpresa({Key? key}) : super(key: key);

  @override
  _HomeEmpresaState createState() => _HomeEmpresaState();
}

class _HomeEmpresaState extends State<HomeEmpresa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Home Empresa'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Bienvenido Empresa',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'rbold',

              ),

            ),

          ),
          Padding(padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: (){

                  },
                  child: Text ('Empresa'),
                ),


              ],
            ),
          ),

        ],


      ),

    );
  }
}
