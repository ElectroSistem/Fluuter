

import 'dart:core';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logisticaduran/components/background-register.dart';
import 'package:logisticaduran/components/background.dart';
import 'package:logisticaduran/Screens/Administrador/home-admin.dart';
import 'package:logisticaduran/utils/my_colors.dart';
import '../../login.dart';

class RegisterInstituto extends StatefulWidget {
  @override
  _RegisterInstitutoState createState() => _RegisterInstitutoState();


}

class _RegisterInstitutoState extends State<RegisterInstituto> {
  DateTime? _dateTimeFechaGrado;

  var selectedNameInstituto;
  var selectedNamePais;



  String dropdownValue = 'Seleccionar País';
  String dropdownValue1 = 'Seleccionar Instituto';
  String dropdownValuePais = 'Seleccionar Pais';






  TextEditingController nitInstitucionController = TextEditingController();
  TextEditingController passwordInstitucionController = TextEditingController();
  TextEditingController nombreInstitucionController = TextEditingController();
  TextEditingController direccionInstitucionController = TextEditingController();
  TextEditingController emailInstitucionController = TextEditingController();
  TextEditingController paisInstitucionController = TextEditingController();
  TextEditingController ciudadInstitucionController = TextEditingController();
  TextEditingController contactoInstitucionController = TextEditingController();
  TextEditingController telefonoInstitucionController = TextEditingController();


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

    paisInstitucionController.text = selectedNamePais;


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



    var url = Uri.parse('https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/registerIntituto.php');

    var response = await http.post(url, body: {





      "id_instituto": nitInstitucionController.text,
      "password": passwordInstitucionController.text,
      "nombre_instituto": nombreInstitucionController.text,
      "direccion_instituto" : direccionInstitucionController.text,
      "email_instituto": emailInstitucionController.text,
      "pais_instituto": paisInstitucionController.text,
      "ciudad_instituto": ciudadInstitucionController.text,
      "nombre_contacto_instituto": contactoInstitucionController.text,
      "telefono_contacto_instituto": telefonoInstitucionController.text,



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
                                Text('Institución Registrada con Exito !!!!',
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

      body: BackgroundRegister(
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




                    _textFieldNit(),
                    _textFieldPassword(),
                    _textFieldNombreInstitucion(),
                    _textFieldDireccion(),
                    _textFieldEmail(),
                    _dropFieldPais(),
                    _textFieldCiudad(),
                    _textFieldContacto(),
                    _textFieldTelefono(),

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
        controller: nitInstitucionController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Nit',
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
        controller: passwordInstitucionController,
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

  Widget _textFieldNombreInstitucion() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: nombreInstitucionController,
        decoration: InputDecoration(
            hintText: 'Nombre de la Institución',
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
        controller: direccionInstitucionController,

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
        controller: emailInstitucionController,
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
        controller: ciudadInstitucionController,
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

  Widget _textFieldContacto() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: contactoInstitucionController,
        decoration: InputDecoration(
            hintText: 'Nombre del Contacto',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldTelefono() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: telefonoInstitucionController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Teléfono de Contacto',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.phone,
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
          //print(cedulaEmpleadoController.text);
          // print(usernameEmpleadoController.text);
          // print(passwordEmpleadoController.text);
          //print(nameEmpleadoController.text);
          //print(apellidosEmpleadoController.text);
          // print(direccionEmpleadoController.text);
          //print(telefonoEmpleadoController.text);
          //print(selectedNamePais);
          // print(_dateTimeFechaGrado);
          // print(selectedNameInstituto);


          if(nitInstitucionController.text.isEmpty || passwordInstitucionController.text.isEmpty || nombreInstitucionController.text.isEmpty
              || direccionInstitucionController.text.isEmpty || emailInstitucionController.text.isEmpty || ciudadInstitucionController.text.isEmpty
              || contactoInstitucionController.text.isEmpty || emailInstitucionController.text.isEmpty || selectedNamePais == null ){

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
                  "REGISTRO INSTITUTO",
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