import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeInstituto extends StatefulWidget {
  const HomeInstituto({Key? key}) : super(key: key);

  @override
  _HomeInstitutoState createState() => _HomeInstitutoState();
}

class _HomeInstitutoState extends State<HomeInstituto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Home Instituto'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Bienvenido Instituto',
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
                  child: Text ('Instituto'),
                ),


              ],
            ),
          ),

        ],


      ),

    );
  }
}
