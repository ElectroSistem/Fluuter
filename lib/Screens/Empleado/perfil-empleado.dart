
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:dio/dio.dart';
import 'package:logisticaduran/Screens/Empresa/home-empresa.dart';
import 'package:logisticaduran/components/background-register-empresa.dart';
import 'package:logisticaduran/components/background-register.dart';
import 'package:logisticaduran/utils/AppTheme.dart';
import 'package:logisticaduran/utils/my_colors.dart';
import 'package:logisticaduran/utils/oval-right-clipper.dart';


import 'package:loading_animations/loading_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../login.dart';
import 'home-empleado.dart';


List lstTask=[];



class PerfilEmpleado extends StatefulWidget {


  String id_empleado;
  String password;
  String nombres_empleado;
  String apellidos_empleado;
  String email_empleado;


  PerfilEmpleado(this.id_empleado,this.password, this.nombres_empleado,this.apellidos_empleado,this.email_empleado);


  @override
  _PerfilEmpleadoState createState() => _PerfilEmpleadoState();
}

class _PerfilEmpleadoState extends State<PerfilEmpleado> {

  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;




  File? imagen;
  File? imagen2;
  File? imagen3;
  final picker = ImagePicker();

  bool isInternet=false;




  @override
  void initState() {





    super.initState();


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



  Future<Post> getAllUser() async {

    var url = Uri.parse(
        'https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/AllUsersId.php');

    var response = await http.post(url, body: {
      'id_empleado' :  widget.id_empleado,
    });
    var data = json.decode(response.body);
    var datos1 = jsonDecode(response.body);


    print('******************* getAllUser *****************************');
    print(datos1);
    return Post.fromJson(datos1);
  }



  Future  selIMagen(op) async{

    var pickedFile;


    if(op == 1){
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }else{
      pickedFile = await picker.pickImage(source: ImageSource.gallery);

    }

    setState(() {

      if(pickedFile != null){
        imagen = File(pickedFile.path);
        //cortar(File(pickedFile.path));
      }else{
        print('No seleccionastes foto');
      }

    });

    Navigator.of(context).pop();
  }



  Future  selIMagen2(op) async{

    var pickedFile;


    if(op == 1){
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }else{
      pickedFile = await picker.pickImage(source: ImageSource.gallery);

    }

    setState(() {

      if(pickedFile != null){
        imagen2 = File(pickedFile.path);
        //cortar(File(pickedFile.path));
      }else{
        print('No seleccionastes foto');
      }

    });

    Navigator.of(context).pop();
  }



  Future  selIMagen3(op) async{

    var pickedFile;


    if(op == 1){
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }else{
      pickedFile = await picker.pickImage(source: ImageSource.gallery);

    }

    setState(() {

      if(pickedFile != null){
        imagen3 = File(pickedFile.path);
        //cortar(File(pickedFile.path));
      }else{
        print('No seleccionastes foto');
      }

    });

    Navigator.of(context).pop();
  }

  cortar(piked) async{

    File? cortado = await ImageCropper.cropImage(sourcePath: piked.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
    );

    if(cortado != null){
      setState(() {
        imagen = cortado;
      });
    }

  }

  Dio dio = new Dio();

  Future<void> subir_imagen () async{

    _checkInternet();

    for (var i = 1; i <= 3; i++) {

      if (i == 1){

        try{

          String filename = imagen!.path.split('/').last;

          FormData formData = new FormData.fromMap({
            'id_empleado' :  widget.id_empleado,
            'id_tipo_doc' :  '1',
            // 'nombre'  : 'Robinson',
            'file' : await MultipartFile.fromFile(
                imagen!.path, filename: filename
            )
          });

          await dio.post('https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/subir_imagen.php',
              data: formData).then((value) {



            if(value.toString() == '1'){
              print('La Foto1 se subio Correctamente');

              Fluttertoast.showToast(
                  msg: "La foto de la cédula (frente) se subio correctamente",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 25
              );

            }else{
              print('Hubo un Error'+ value.toString());
            }
          });

        }catch(e){
          print(e.toString());
        }

      } // fin del if = 1

      if (i == 2){

        try{

          String filename = imagen2!.path.split('/').last;

          FormData formData = new FormData.fromMap({
            'id_empleado' :  widget.id_empleado,
            'id_tipo_doc' :  '1',
            'file' : await MultipartFile.fromFile(
                imagen2!.path, filename: filename
            )
          });

          await dio.post('https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/subir_imagen.php',
              data: formData).then((value) {

            if(value.toString() == '1'){
              print('La Foto2 se subio Correctamente');

              Fluttertoast.showToast(
                  msg: "La foto de la cédula (atras) se subio correctamente",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 25
              );

            }else{
              print('Hubo un Error'+ value.toString());
            }
          });

        }catch(e){
          print(e.toString());
        }

      } // fin del if = 2


      if (i == 3){

        try{

          String filename = imagen3!.path.split('/').last;

          FormData formData = new FormData.fromMap({
            'id_empleado' :  widget.id_empleado,
            'id_tipo_doc' :  '1',
            'file' : await MultipartFile.fromFile(
                imagen3!.path, filename: filename
            )
          });

          await dio.post('https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/subir_imagen.php',
              data: formData).then((value) {

            if(value.toString() == '1'){
              print('La Foto3 se subio Correctamente');

              Fluttertoast.showToast(
                  msg: "La foto de del perfil profesional con dotacion se subio correctamente",
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
                                        Text('Los documentos se subieron correctamente',
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
              print('Hubo un Error'+ value.toString());
            }
          });

        }catch(e){
          print(e.toString());
        }

      } // fin del if = 3


    } // fin del for





  } // Subir Imagen

  opciones(context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      selIMagen(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Tomar una Foto', style: TextStyle(
                                fontSize: 16
                            ),),

                          ),
                          Icon(Icons.camera_alt, color: Colors.blue,)
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      selIMagen(2);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),

                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Seleccionar una Foto', style: TextStyle(
                                fontSize: 16
                            ),),

                          ),
                          Icon(Icons.image, color: Colors.blue,)
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.red
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Cancelar', style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),textAlign: TextAlign.center,),

                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }


  opciones1(context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      selIMagen2(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Tomar una Foto', style: TextStyle(
                                fontSize: 16
                            ),),

                          ),
                          Icon(Icons.camera_alt, color: Colors.blue,)
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      selIMagen2(2);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),

                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Seleccionar una Foto', style: TextStyle(
                                fontSize: 16
                            ),),

                          ),
                          Icon(Icons.image, color: Colors.blue,)
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.red
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Cancelar', style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),textAlign: TextAlign.center,),

                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }


  opciones2(context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      selIMagen3(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Tomar una Foto', style: TextStyle(
                                fontSize: 16
                            ),),

                          ),
                          Icon(Icons.camera_alt, color: Colors.blue,)
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      selIMagen3(2);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),

                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Seleccionar una Foto', style: TextStyle(
                                fontSize: 16
                            ),),

                          ),
                          Icon(Icons.image, color: Colors.blue,)
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.red
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Cancelar', style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),textAlign: TextAlign.center,),

                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }








  @override
  Widget build(BuildContext context) {
    //getAllUser();

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
        title: Text('Perfil Empleado'),
        backgroundColor: MyColors.primaryColor,
      ),

      drawer: _buildDrawer(),

      body: ListView(
          children: <Widget>[
            SizedBox(height: size.height * 0.03),

/*
            Container(
              child: FutureBuilder<Post>(
                future: getAllUser(),
                builder: (context, snapshot) {


                  if (snapshot.hasData) {
                    return Text("Bienvenido, " +  snapshot.data!.direccion_empleado);

                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // Por defecto, muestra un loading spinner
                  return CircularProgressIndicator();
                },
              ),

            ),
*/
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: AppTheme.appBackground,
              child: ListTile(
                onTap: () {
                  //open edit profile
                },
                title: Text(

                  "Bienvenido, " +  widget.nombres_empleado + ' ' + widget.apellidos_empleado,
                  style: TextStyle(

                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    fontFamily: 'rbold',
                  ),
                ),
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage("https://electrosistem.com.co/ElectroTask/images/FotoPerfil.png"),


                ),

              ),
            ),

            SizedBox(height: size.height * 0.03),
            Card(
                color: AppTheme.appBackground,
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
                                  Text("Documento de Identificación")
                                ],
                              ),
                            ),
                            Image(
                              image: AssetImage("assets/images/ic_idcard_front.png"),
                              height: 40,
                              width: 40,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),


                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text("(Foto con Cédula parte frontal)"),
                            ),
                          ],
                        ),

                        Padding(padding: EdgeInsets.all(10),
                          child: Column(
                            children: [

                              imagen == null ? Center() : Image.file(imagen!)
                            ],
                          ),
                        ),

                        SizedBox(height: 30),
                        Divider(
                          color: AppTheme.tabUnselected,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                            child:Row(
                              children: <Widget>[
                                new GestureDetector(
                                  onTap: () {
                                    opciones(context);
                                    //AllUsers();
                                  },
                                  child:Image(
                                    image: AssetImage("assets/images/ic_attach.png"),
                                    height: 40,
                                    width: 40,
                                  ),
                                ),

                              ],
                            )
                        ),
                      ],
                    )
                )
            ),

            SizedBox(height: size.height * 0.03),

            Card(
                color: AppTheme.appBackground,
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
                                  Text("Documento de Identificación")
                                ],
                              ),
                            ),
                            Image(
                              image: AssetImage("assets/images/ic_idcard_back.png"),
                              height: 40,
                              width: 40,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                                child: Text("(Foto con Cédula parte de atras)")
                            ),

                          ],
                        ),

                        Padding(padding: EdgeInsets.all(10),
                          child: Column(
                            children: [

                              imagen2 == null ? Center() : Image.file(imagen2!)
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Divider(
                          color: AppTheme.tabUnselected,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                            child:Row(
                              children: <Widget>[
                                new GestureDetector(
                                  onTap: () {
                                    opciones1(context);
                                  },
                                  child:Image(
                                    image: AssetImage("assets/images/ic_attach.png"),
                                    height: 40,
                                    width: 40,
                                  ),
                                ),

                              ],
                            )
                        ),
                      ],
                    )
                )
            ),
            SizedBox(height: size.height * 0.03),



            Card(
                color: AppTheme.appBackground,
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
                                  Text("Foto actual para perfil laboral ")
                                ],
                              ),
                            ),
                            Image(
                              image: AssetImage("assets/images/ic_dotacion.png"),
                              height: 40,
                              width: 40,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                                child: Text("(Cuerpo entero con dotación a usar)")
                            ),

                          ],
                        ),

                        Padding(padding: EdgeInsets.all(10),
                          child: Column(
                            children: [

                              imagen3 == null ? Center() : Image.file(imagen3!)
                            ],
                          ),
                        ),

                        SizedBox(height: 30),
                        Divider(
                          color: AppTheme.tabUnselected,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                            child:Row(
                              children: <Widget>[
                                new GestureDetector(
                                  onTap: () {
                                    opciones2(context);
                                  },
                                  child:Image(
                                    image: AssetImage("assets/images/ic_attach.png"),
                                    height: 40,
                                    width: 40,
                                  ),
                                ),

                              ],
                            )
                        ),
                      ],
                    )
                )
            ),


            Padding(padding: EdgeInsets.all(20),
              child: Column(
                children: [


                  FlatButton(
                    child: Text("Enviar",
                        style: new TextStyle(
                            fontSize: 16,
                            fontFamily: "AppBold")
                    ),
                    onPressed: () {
                      subir_imagen();
                    },
                    color: AppTheme.appButtonprimaryOpacityRed,
                    textColor: AppTheme.appWhite,
                    padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
                    splashColor: AppTheme.appButtonprimaryOpacityRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      side: BorderSide(color: AppTheme.appButtonprimaryOpacityRed),
                    ),
                  ),

                ],
              ),
            ),
          ]


      ),
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




