import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:dio/dio.dart';
import 'package:logisticaduran/Screens/Empleado/home-empleado.dart';
import 'package:logisticaduran/Screens/Empresa/home-empresa.dart';
import 'package:logisticaduran/Screens/Instituto/home-instituto.dart';
import 'components/background.dart';
import 'Screens/Administrador/home-admin.dart';
import 'Screens/register/register-prestador.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logisticaduran/utils/my_colors.dart';





class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();


}

class _LoginState extends State<Login> {



  TextEditingController usuario = TextEditingController();
  TextEditingController passwordDigitado = TextEditingController();

  bool _obscureText = true;
  bool _passwordVisible = true;
  bool _obscureText2 = true;
  bool _passwordVisible2 = true;

  void _toggle1() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }



  Future login() async {
    _checkInternet();
    //print('=================== Datos 01 ===============================');
    //print(usuario.text);
   // print(password.text);

    var url = Uri.parse('https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/loginTablaRelacion.php');
    var response = await http.post(url, body: {
      "id_user": usuario.text,
      "password_user": passwordDigitado.text,
    });
    var data = json.decode(response.body);
    var datos = jsonDecode(response.body);

    //print('=================== Datos ===============================');
    //print(datos);




    if (datos != 0) {
      var idEmpleado =  datos['id_user'];
      if (datos["estado_user"] != '0') {
        // print('******************* OK *****************************');
        /// print(datos);



        var url = Uri.parse(
            'https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/AllUsersId.php');

        var response = await http.post(url, body: {
          'id_empleado' :  idEmpleado,
        });
        var data = json.decode(response.body);
        var datos1 = jsonDecode(response.body);

        print('******************* OK *****************************');
        print(datos1);



        guardar_datos(datos1['id_empleado'],datos1['password'],datos1['nombres_empleado'],datos1['apellidos_empleado'],datos1['email_empleado']);

        Fluttertoast.showToast(
            msg: "Login Exitoso !!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 25
        );



        // Pagina de Admin
        if (datos['id_rol_user'] == '1') {


          var url = Uri.parse(
              'https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/AllUsersId.php');

          var response = await http.post(url, body: {
            'id_empleado' :  idEmpleado,
          });
          var data = json.decode(response.body);
          var datos1 = jsonDecode(response.body);

        //  print('******************* DATOS 1 *****************************');
        //  print(datos1);

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return new Homeadmin(
                    datos1['id_empleado'],
                  datos1['password'],
                    datos1['nombres_empleado'],
                    datos1['apellidos_empleado'],
                    datos1['email_empleado']
                    );
              }
          ), (route) => false);


        }

        // Pagina de Empleados
        if (datos['id_rol_user'] == '2') {
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeEmpleado(),),);

          var url = Uri.parse(
              'https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/AllUsersId.php');

          var response = await http.post(url, body: {
            'id_empleado' :  idEmpleado,
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


        }

        // Pagina de Institutos
        if (datos['id_rol_user'] == '3') {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeInstituto(),),);
        }

        // Pagina de Empresas
        if (datos['id_rol_user'] == '4') {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeEmpresa(),),);
        }
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeEmpleado(),),);
        //Navigator.pushNamed(context, '/homeadmin', arguments: {'usuario': datos['username'], 'password': datos['password']});


/*
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<Null>(
          builder: (BuildContext context){
        return new Homeadmin(datos['nombres_empleado'],datos['username'],datos['id_empleado']);
      }
      ), (route) => false);
*/

      }else {
        //print('Contacte al Administrador para la activacion de su Usuario');
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
                                  Text('Contacte al Administrador para la activacion de su Usuario',
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

      } //else de los datos diferentes de 0, osea que hay datos
    }else{
      //print('Verifique los datos de acceso o contacte al Administrador');
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
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                  'Verifique los datos de acceso o contacte al Administrador',
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

                                  onPressed: () {
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


    } // else usuario o contrasena mal

  }


  Future<void> guardar_datos(id_empleado,password,nombres_empleado, apellidos_empleado,email_empleado) async{

   // print('******************* GuardAR  *****************************');
   // print(id_empleado);
   // print(password);
  ///  print(nombres_empleado);
   // print(apellidos_empleado);
   // print(email_empleado);


    SharedPreferences prefs = await SharedPreferences.getInstance();



    await prefs.setString('id_empleado', id_empleado);
    await prefs.setString('password', password);

    await prefs.setString('nombres_empleado', nombres_empleado);
    await prefs.setString('apellidos_empleado', apellidos_empleado);
    await prefs.setString('email_empleado', email_empleado);



  }


  String? id_empleado;
  String? password;
  String? nombres_empleado;
  String? apellidos_empleado;
  String? email_empleado;

  bool isInternet=false;




  Future<void> mostrar_datos() async {
    print('******************* mostarr *****************************');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    id_empleado = await prefs.getString('id_empleado');
    password = await prefs.getString('password');

    nombres_empleado = await prefs.getString('nombres_empleado');
    apellidos_empleado = await prefs.getString('apellidos_empleado');
    email_empleado = await prefs.getString('email_empleado');



    //print(id);
    if(id_empleado != ''){
      if(id_empleado != null){

        var url = Uri.parse('https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/loginTablaRelacion.php');
        var response = await http.post(url, body: {
          "id_user": id_empleado,
          "password_user": password,
        });

        var datos = jsonDecode(response.body);

        print('=================== Datos Mostrar ===============================');
        print(datos);



        // Pagina de Admin
        if (datos['id_rol_user'] == '1') {


          var url = Uri.parse(
              'https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/AllUsersId.php');

          var response = await http.post(url, body: {
            'id_empleado' :  id_empleado,
          });
          var data = json.decode(response.body);
          var datos1 = jsonDecode(response.body);

          //  print('******************* DATOS 1 *****************************');
          //  print(datos1);

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return new Homeadmin(
                    datos1['id_empleado'],
                    datos1['password'],
                    datos1['nombres_empleado'],
                    datos1['apellidos_empleado'],
                    datos1['email_empleado']
                );
              }
          ), (route) => false);


        }

        // Pagina de Empleados
        if (datos['id_rol_user'] == '2') {
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeEmpleado(),),);

          var url = Uri.parse(
              'https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/AllUsersId.php');

          var response = await http.post(url, body: {
            'id_empleado' :  id_empleado,
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


        }

        // Pagina de Institutos
        if (datos['id_rol_user'] == '3') {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeInstituto(),),);
        }

        // Pagina de Empresas
        if (datos['id_rol_user'] == '4') {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeEmpresa(),),);
        }





      }
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mostrar_datos();


    _checkInternet();


    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        setState(() {
          isInternet=true;
        });
        print("==============I am connected to a mobile network.");

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
      });
      print("========I am connected to a mobile network.");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      setState(() {
        isInternet = true;
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



  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "DATOS DE ACCESO",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 248, 78, 80),

                    fontSize: 36
                ),
                textAlign: TextAlign.left,
              ),
            ),

            SizedBox(height: size.height * 0.03),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
              decoration: BoxDecoration(
                  color: MyColors.primaryOpacityColor,
                  borderRadius: BorderRadius.circular(30)),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: usuario,
                decoration: InputDecoration(
                    hintText: 'Cédula o Nit',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    hintStyle: TextStyle(color: MyColors.primaryColor),
                    prefixIcon: Icon(
                      Icons.person,
                      color: MyColors.primaryColor,
                    )),
              ),
            ),

            SizedBox(height: size.height * 0.03),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
              decoration: BoxDecoration(
                  color: MyColors.primaryOpacityColor,
                  borderRadius: BorderRadius.circular(30)),
              child: TextField(
                controller: passwordDigitado,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  hintStyle:
                  TextStyle(color: MyColors.primaryColor),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: MyColors.primaryColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: MyColors.primaryColor,
                    ),
                    onPressed: () {
                      _toggle1();
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
/*
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                "Forgot your password?",
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0XFF2661FA)
                ),
              ),
            ),
*/
            SizedBox(height: size.height * 0.05),

            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () {

                  if(usuario.text.isEmpty || passwordDigitado.text.isEmpty){
                    //print('****** Campor Vacios ****************');
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
                                              Text('Digite todos los campos',
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


                  }else{
                    login();
                  }





                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(
                          colors: [
                            Color.fromARGB(255, 238, 49, 53),
                            Color.fromARGB(255, 248, 78, 80),
                          ]
                      )
                  ),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "INGRESAR",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),

            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context, '/roles-page')
                },
                child: Text(
                  "No Tienes Cuenta? Registrate Aqui!!",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 11, 54, 156)
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }

}
