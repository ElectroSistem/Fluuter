

import 'dart:core';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logisticaduran/components/background-register-empresa.dart';
import 'package:logisticaduran/components/background-register.dart';
import 'package:logisticaduran/components/background.dart';
import 'package:logisticaduran/Screens/Administrador/home-admin.dart';
import 'package:logisticaduran/utils/my_colors.dart';
import '../../login.dart';

class RegisterEmpresa extends StatefulWidget {
  @override
  _RegisterEmpresaState createState() => _RegisterEmpresaState();


}

class _RegisterEmpresaState extends State<RegisterEmpresa> {
  DateTime? _dateTimeFechaGrado;

  var selectedNameInstituto;
  var selectedNamePais;



  String dropdownValue = 'Seleccionar País';
  String dropdownValue1 = 'Seleccionar Instituto';
  String dropdownValuePais = 'Seleccionar Pais';





  TextEditingController nitEmpresaController = TextEditingController();
  TextEditingController passwordEmpresaController = TextEditingController();
  TextEditingController nombreEmpresaController = TextEditingController();
  TextEditingController direccionEmpresaController = TextEditingController();
  TextEditingController emailEmpresaController = TextEditingController();
  TextEditingController paisEmpresaController = TextEditingController();
  TextEditingController ciudadEmpresaController = TextEditingController();
  TextEditingController patchEmpresaController = TextEditingController();



  var selectDate;
  var _currenSelectedDate;

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






  Future register() async {
    //print('******************* REGISTER *****************************');

    paisEmpresaController.text = selectedNamePais;


    // print(paisEmpleadoController);
    //  print(cedulaEmpleadoController.text);
    //  print(usernameEmpleadoController.text);
    // print(passwordEmpleadoController.text);
    //  print(nameEmpleadoController.text);
    // print(apellidosEmpleadoController.text);
    // print(direccionEmpleadoController.text);
    // print(telefonoEmpleadoController.text);
    //  print(emailEmpleadoController.text);
    //  print(paisEmpleadoController.text);
    // print(fechaGradoEmpleadoController.text);
    //  print(institutoEmpleadoController.text);
    //  print(rolEmpleadoController.text);

    var url = Uri.parse('https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/registerEmpresa.php');

    var response = await http.post(url, body: {



      "id_empresa": nitEmpresaController.text,
      "password": passwordEmpresaController.text,
      "nombre_empresa": nombreEmpresaController.text,
      "direccion_empresa" : direccionEmpresaController.text,
      "email_empresa": emailEmpresaController.text,
      "pais_empresa": paisEmpresaController.text,
      "ciudad_empresa": ciudadEmpresaController.text,
      "path_doc_empresa": patchEmpresaController.text,




    });

    var data = json.decode(response.body);

    print('================== DATA ========================');
    print(data);

    if (data == "Error") {
      Fluttertoast.showToast(
          msg: "La Institución Ya se encuentra registrada en LogiStaff",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
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
                                Text('Empresa Registrada con Exito !!!!',
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

                                    Navigator.pushNamed(context, '/login');
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: BackgroundRegisterEmpresa(
        child: Stack(

          children: [
            SafeArea(child: _circle()),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 150),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //_imageUser(),
                    SizedBox(height: 30),

                    SizedBox(height: size.height * 0.05),


                    _textFieldNit(),
                    _textFieldPassword(),
                    _textFieldNombreEmpresa(),
                    _textFieldDireccion(),
                    _textFieldEmail(),
                    _dropFieldPais(),
                    _textFieldCiudad(),
                    _textPatch(),

                    _buttonRegister(),
                    Container(
                      alignment: Alignment.center,

                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()))
                        },
                        child: Text(
                          "Tienes una Cuenta? Ingresa Aqui!!",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'rbold',
                              color: Color.fromARGB(255, 11, 54, 156)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.09),




                  ],
                ),
              ),
            )
          ],


        ),
      ),
    );
  }



  Widget _textFieldNit() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: nitEmpresaController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Nit Empresa',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.credit_card_outlined,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: passwordEmpresaController,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: 'Contraseña',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle:
          TextStyle(color: MyColors.primaryColorDark),
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
    );

  }

  Widget _textFieldNombreEmpresa() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: nombreEmpresaController,
        decoration: InputDecoration(
            hintText: 'Nombre de la Empresa',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.business_rounded,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldDireccion() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: direccionEmpresaController,

        decoration: InputDecoration(
            hintText: 'Dirección',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.location_on_rounded,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: emailEmpresaController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo Electrónico',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.email,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _dropFieldPais(){

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30),


      ),


      child: DropdownButton<String>(

        value: selectedNamePais,

        hint: dropdownValuePais == null ? Text("Seleccionar Pais",  style: TextStyle(color: Colors.black), ): Text(dropdownValuePais, style: TextStyle(color: MyColors.primaryColorDark)),
        isExpanded: true,
        iconSize: 36,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.red,),
        elevation: 16,
        style: TextStyle(color: Colors.black),

        underline: Container(
          height: 0,
          color: MyColors.primaryOpacityColor,
        ),
        onChanged: (value) {
          setState(() {
            selectedNamePais = value;
            print(selectedNamePais);
          });
        },

        items: <String>['Colombia', 'Argentina']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Icon(Icons.vpn_lock_rounded,
                  color: MyColors.primaryColor,),
                Padding(padding: EdgeInsets.all(3)) ,
                Text(value),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _textFieldCiudad() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: ciudadEmpresaController,
        decoration: InputDecoration(
            hintText: 'Ciudad',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.gps_fixed_rounded,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textPatch() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: patchEmpresaController,
        decoration: InputDecoration(
            hintText: 'Path',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.file_copy,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }




  Widget _buttonRegister() {

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: () {
          print(nitEmpresaController.text);
           print(passwordEmpresaController.text);
           print(nombreEmpresaController.text);
          print(direccionEmpresaController.text);
          print(emailEmpresaController.text);
           print(ciudadEmpresaController.text);
          print(selectedNamePais);
          print(patchEmpresaController.text);
          //print(selectedNamePais);
          // print(_dateTimeFechaGrado);
          // print(selectedNameInstituto);


          if(nitEmpresaController.text.isEmpty || passwordEmpresaController.text.isEmpty || nombreEmpresaController.text.isEmpty
              || direccionEmpresaController.text.isEmpty || emailEmpresaController.text.isEmpty || selectedNamePais == null
              || ciudadEmpresaController.text.isEmpty || patchEmpresaController.text.isEmpty){

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

          }else {
            register();
          }
        },
        child: Text('REGISTRARSE'),

        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,

            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _circle() {
    return GestureDetector(
      //onTap: Navigator.pop(context),
      child: Container(
        width: 180,
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
                  "REGISTRO EMPRESA",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
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