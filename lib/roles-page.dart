import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logisticaduran/Screens/register/register-empresas.dart';
import 'package:logisticaduran/Screens/register/register-instituto.dart';
import 'package:logisticaduran/components/background-rol.dart';
import 'package:logisticaduran/utils/my_colors.dart';


import 'Screens/register/register-prestador.dart';
import 'login.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({Key? key}) : super(key: key);

  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: BackgroundRol(
        child: Stack(
          children: [
            SafeArea(child: _circle()),

            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 150),

                child: ListView(
                  children: [
                    Container(
                      height: 100,
                      child: FadeInImage(
                        image: AssetImage('assets/images/prestador-servicio.png'),
                        fit: BoxFit.contain,
                        fadeInDuration: Duration(milliseconds: 50),
                        placeholder: AssetImage('assets/images/prestador-servicio.png'),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      alignment: Alignment.center,

                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()))
                        },
                        child: Text(
                          "Prestador de Servicios",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'rbold',

                              color: MyColors.primaryColor
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 55),



                    Container(
                      height: 100,
                      child: FadeInImage(
                        image: AssetImage('assets/images/institutos.png'),
                        fit: BoxFit.contain,
                        fadeInDuration: Duration(milliseconds: 50),
                        placeholder: AssetImage('assets/images/institutos.png'),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      alignment: Alignment.center,

                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterInstituto()))
                        },
                        child: Text(
                          "Institutos",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'rbold',

                              color: MyColors.primaryColor
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 55),


                    Container(
                      height: 100,
                      child: FadeInImage(
                        image: AssetImage('assets/images/empresas.png'),
                        fit: BoxFit.contain,
                        fadeInDuration: Duration(milliseconds: 50),
                        placeholder: AssetImage('assets/images/empresas.png'),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      alignment: Alignment.center,

                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterEmpresa()))
                        },
                        child: Text(
                          "Empresas",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'rbold',

                              color: MyColors.primaryColor
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 55),
                  ],
                ),

            )
          ],


        ),
    ),
    );
  }


  Widget _circle() {
    return GestureDetector(
      //onTap: Navigator.pop(context),
      child: Container(
        width: 170,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(80)),
          color: MyColors.primaryColor,
        ),
        child: Container(
          margin: EdgeInsets.only(left: 9, top: 0, bottom: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  "ROL DE REGISTRO",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: "rbold",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
