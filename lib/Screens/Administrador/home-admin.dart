import 'dart:convert';



import 'dart:async';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity/connectivity.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logisticaduran/Screens/Empleado/home-empleado.dart';
import 'package:logisticaduran/Screens/Empresa/home-empresa.dart';

import 'package:logisticaduran/utils/AppTheme.dart';
import 'package:logisticaduran/utils/model.dart';
import 'package:logisticaduran/utils/my_colors.dart';
import 'package:logisticaduran/utils/oval-right-clipper.dart';


import 'package:loading_animations/loading_animations.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../login.dart';


List<Model> lstTask=[];
List dataUsersDisable=[];


class Homeadmin extends StatefulWidget {



  String id_empleado;
  String password;
  String nombres_empleado;
  String apellidos_empleado;
  String email_empleado;


  Homeadmin(this.id_empleado,this.password, this.nombres_empleado,this.apellidos_empleado,this.email_empleado);


  @override
  _HomeadminState createState() => _HomeadminState();
}

class _HomeadminState extends State<Homeadmin> {



  bool showLoader=false;
  bool saving = true;



  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;




  File? imagen;
  File? imagen2;
  File? imagen3;
  final picker = ImagePicker();

  bool isInternet=false;

  TextStyle noRecordFoundStyle = TextStyle(fontFamily: 'AppBold', fontSize: 18.0, color: AppTheme.appColor);



  TextStyle itemTitleStyle = TextStyle(fontFamily: 'AppBold', fontSize: 16.0, color: AppTheme.taskItemTitle);
  TextStyle itemDescStyle = TextStyle(fontFamily: 'AppLight', fontSize: 15.0, color: AppTheme.taskItemDesc);
  TextStyle itemTimeStyle = TextStyle(fontFamily: 'AppItalic', fontSize: 13.0, color: AppTheme.taskItemTime);
  TextStyle itemInstitutoStyle = TextStyle(fontFamily: 'AppLight', fontSize: 15.0, color: AppTheme.taskItemInstituto);




  @override
  void initState() {
    super.initState();

    _checkInternet();

    getAllUser();



    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        setState(() {
          isInternet=true;

        });
        print("==============I am connected to a mobilejjjjjj network.");

      } else if (result == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        setState(() {
          isInternet=true;

        });
        print("=========I am connected to a wifi network.");
      }
      else
      {
        setState(() {
          isInternet=false;
        });
        print("===========No internet connection!");
      }
    });
  }

  _checkInternet() async
  {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      setState(() {
        isInternet = true;
        //AllUsers();
      });
      print("========I am connected to a mobile network.");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      setState(() {
        isInternet = true;
        //AllUsers();
      });
      print("=========I am connected to a wifi network.");
    }
    else
    {
      setState(() {
        isInternet = false;
      });
      print("===========No internet connection!");

      Fluttertoast.showToast(
          msg: "Revise su conexión a internet !!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 25
      );

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)
              ),
              child: Container(
                height: 200,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white70,
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.redAccent,
                        child: SizedBox.expand(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Revise su conexión a internet !!!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'rbold',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white, // background
                                    onPrimary: Colors.redAccent, // foreground
                                  ),

                                  child: Text('Aceptar'),

                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });

    }
  }



  List? data1;

  Future getAllUser() async {
    var response = await http.get(
        Uri.parse("https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/AllUsersDisable.php"),
        headers: {
          "Accept": "application/json"
        }
    );
    this.setState(() {
      dataUsersDisable = json.decode(response.body);
    });
 //   print('===============getData==============');
  //  print(dataUsersDisable[1]["nombres_empleado"]);
   return "Success!";
  }

  Future getAllUserRefresh() async {
    print('===============getData==============');
    var response = await http.get(
        Uri.parse("https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/AllUsersDisable.php"),
        headers: {
          "Accept": "application/json"
        }
    );
    this.setState(() {
      dataUsersDisable = json.decode(response.body);
    });
    //   print('===============getData==============');
    //  print(dataUsersDisable[1]["nombres_empleado"]);
    return "Success!";
  }




  @override
  Widget build(BuildContext context) {
    //getAllUser();

    if (dataUsersDisable != 0) {
      saving = false;

    }

    Size size = MediaQuery.of(context).size;
    ////Map parametros = ModalRoute.of(context)!.settings.arguments as Map;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Home Admin'),
        backgroundColor: MyColors.primaryColor,
      ),


      drawer: _buildDrawer(),
      body:RefreshIndicator(
        onRefresh: getAllUserRefresh,
            child: Container(
              decoration: BoxDecoration(
                  color: AppTheme.appBackground
              ),
              child: Center(
                child: Column(
                  children: <Widget>[



                    Expanded(
                        child: showLoader?
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            new CircularProgressIndicator(

                            ),
                          ],
                        ):dataUsersDisable.length==0?
                        Center(


                            child: new Text("No hay usuarios por autorizar, Click Aquí para Actualizar", style: noRecordFoundStyle,

                            ),




                        ):
                        ListView.builder(
                            itemCount: dataUsersDisable.length,

                            padding: EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                            itemBuilder: (context, index) {
                              return Column(
                                  children: <Widget>[
                                    Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        elevation: 2,
                                        margin: EdgeInsets.all(8.0),
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                                            child:Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(dataUsersDisable[index]["nombres_empleado"] + " " + dataUsersDisable[index]["apellidos_empleado"], style: itemTitleStyle,)
                                                        ],
                                                      ),
                                                    ),
                                                    Text(dataUsersDisable[index]["id_empleado"], style: itemDescStyle,)
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                        child: Text(dataUsersDisable[index]["direccion_empleado"], style: itemDescStyle,)

                                                    ),

                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                        child: Text(dataUsersDisable[index]["telefono_empleado"], style: itemDescStyle,)

                                                    ),

                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                        child: Text(dataUsersDisable[index]["email_empleado"], style: itemDescStyle,)

                                                    ),

                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                        child: Text(dataUsersDisable[index]["nombre_instituto"], style: itemDescStyle,)

                                                    ),

                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                        child: Text(dataUsersDisable[index]["nombre_contacto_instituto"], style: itemDescStyle,)

                                                    ),

                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                        child: Text(dataUsersDisable[index]["telefono_contacto_instituto"], style: itemDescStyle,)

                                                    ),

                                                  ],
                                                ),

                                                SizedBox(height: 30),
                                                Divider(
                                                  color: AppTheme.taskItemLine,
                                                  thickness: 1,
                                                  height: 1,
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                                                    child:Row(
                                                      children: <Widget>[
                                                        new GestureDetector(
                                                          onTap: () {

                                                          },
                                                          child:Image(
                                                            image: AssetImage("assets/images/ic_edit.png"),
                                                            height: 40,
                                                            width: 40,
                                                          ),
                                                        ),
                                                        new GestureDetector(
                                                          onTap: () {

                                                          },
                                                          child:Image(
                                                            image: AssetImage("assets/images/ic_delete.png"),
                                                            height: 40,
                                                            width: 40,
                                                          ),
                                                        ),
                                                        new GestureDetector(
                                                          onTap: () {

                                                          },
                                                          child:Image(
                                                            image: AssetImage("assets/images/ic_share.png"),
                                                            height: 40,
                                                            width: 40,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: <Widget>[
                                                              FlatButton(
                                                                child: Text("Completar Tarea",
                                                                    style: new TextStyle(
                                                                        fontSize: 14,
                                                                        fontFamily: "AppBold")
                                                                ),
                                                                onPressed: () {

                                                                },
                                                                color: AppTheme.appButtonGreen,
                                                                textColor: AppTheme.appWhite,
                                                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                                splashColor: AppTheme.appButtonGreen,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: new BorderRadius.circular(25.0),
                                                                  side: BorderSide(color: AppTheme.appButtonGreen),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ],
                                            )
                                        )
                                    ),
                                    SizedBox(height: index==lstTask.length-1?70:0),
                                  ]
                              );
                            }
                        )
                    ),



                    /*Divider(
                    color: AppTheme.tabUnselected,
                    thickness: 1,
                    height: 1,
                  ),*/
                  ],
                ),
              ),

          )),
// Por defecto, muestra un loading spinner

    );
  }

  _buildDrawer() {
    //final String image = images[0];
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: AppTheme.appButtonprimaryOpacityRed,
                      ),
                      onPressed: () {
                        signOutNormal();
                      },
                    ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [AppTheme.appButtonprimaryOpacityRed, AppTheme.appButtonprimaryOpacityRed])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage("https://electrosistem.com.co/ElectroTask/images/FotoPerfil.png"),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                      widget.nombres_empleado + ' ' + widget.apellidos_empleado,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.email_empleado,
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),

                  //  Empieza el Menu

                  _buildRowHome(),
                  _buildDivider(),

                  _buildRowPerfil(),
                  _buildDivider(),

                  _buildRowConfig(),
                  _buildDivider(),

                  _buildRowContacto(),
                  _buildDivider(),

                  _buildRowEmpleado(),
                  _buildDivider(),

                  /*
                  _buildRow(Icons.person_pin, "My profile"),
                  _buildDivider(),
                  _buildRow(Icons.message, "Messages"),
                  _buildDivider(),
                  _buildRow(Icons.notifications, "Notifications"),
                  _buildDivider(),
                  _buildRow(Icons.settings, "Settings"),
                  _buildDivider(),
                  _buildRow(Icons.email, "Contact us"),
                  _buildDivider(),
                  _buildRow(Icons.info_outline, "Help"),
                  _buildDivider(),
                  */

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRowHome(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          Icons.home,
          color: active,
        ),
        SizedBox(width: 10.0),
        new GestureDetector(
          onTap: () {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeEmpresa(),),);
          },
          child: Text("Home",
            style: TextStyle(color: active, fontSize: 16.0),
          ),
        ),
        Spacer(),
      ]),
    );
  }

  Widget _buildRowPerfil(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          Icons.person_pin,
          color: active,
        ),
        SizedBox(width: 10.0),
        new GestureDetector(
          onTap: () {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeEmpresa(),),);
          },
          child: Text("My Perfil",
            style: TextStyle(color: active, fontSize: 16.0),
          ),
        ),
        Spacer(),
      ]),
    );
  }


  Widget _buildRowConfig(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          Icons.settings,
          color: active,
        ),
        SizedBox(width: 10.0),
        new GestureDetector(
          onTap: () {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeEmpresa(),),);
          },
          child: Text("Configuracion",
            style: TextStyle(color: active, fontSize: 16.0),
          ),
        ),
        Spacer(),
      ]),
    );
  }


  Widget _buildRowContacto(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          Icons.email,
          color: active,
        ),
        SizedBox(width: 10.0),
        new GestureDetector(
          onTap: () {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeEmpresa(),),);
          },
          child: Text("Contactanos",
            style: TextStyle(color: active, fontSize: 16.0),
          ),
        ),
        Spacer(),
      ]),
    );
  }



  Widget _buildRowEmpleado(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          Icons.email,
          color: active,
        ),
        SizedBox(width: 10.0),
        new GestureDetector(
          onTap: () async {
            var url = Uri.parse(
                'https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/AllUsersId.php');

            var response = await http.post(url, body: {
              'id_empleado' :  widget.id_empleado,
            });
            var data = json.decode(response.body);
            var datos1 = jsonDecode(response.body);

            //  print('******************* DATOS 1 *****************************');
            //  print(datos1);

            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  return new HomeEmpleado(
                      datos1['id_empleado'],
                      datos1['password'],
                      datos1['nombres_empleado'],
                      datos1['apellidos_empleado'],
                      datos1['email_empleado']
                  );
                }
            ), (route) => false);
          },
          child: Text("Contactanos",
            style: TextStyle(color: active, fontSize: 16.0),
          ),
        ),
        Spacer(),
      ]),
    );
  }

  /*
  Widget _buildRow(IconData icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: active,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),

      ]),
    );
  }
*/

  Future<void> signOutNormal()
  async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    Fluttertoast.showToast(
        msg: "Logout Exitoso !!!!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 25
    );


    navigationLoginPage();
  }

  void navigationLoginPage() {
    //Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName);
    Navigator.of(context).pushReplacement(_createWelcomeRoute());
  }
  Route _createWelcomeRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Login(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

}

class Post {

  final String direccion_empleado;
  final String telefono_empleado;


  Post({required this.direccion_empleado, required this.telefono_empleado});


  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      direccion_empleado: json['direccion_empleado'],
      telefono_empleado: json['telefono_empleado'],



    );
  }
}




