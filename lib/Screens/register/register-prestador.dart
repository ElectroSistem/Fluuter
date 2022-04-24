

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

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();


}

class _RegisterState extends State<Register> {
DateTime? _dateTimeFechaGrado;

var selectedNameInstituto;
var selectedNamePais;

  var ListaInstitutoM = new List.filled(2, null, growable: false);

  @override
  void initState(){
    super.initState();
    ListaInstitutos();
  }

  List? ListaInstituto;
List? data;

  Future ListaInstitutos() async {
    var url = Uri.parse('https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/ListaInstitutos.php');
    var response = await http.post(url, body: {});
    setState(() {
      var respuesta = json.decode(response.body);
      data = json.decode(response.body);
    });
   // print('===============DROP==============');
  // print(data);
   // print(json.decode(response.body));
    //llenarComboBox();


  }



String? _dropValue;
Map<String,String>listaInstitutosM = Map();

  void llenarComboBox(){
    var logitud = ListaInstituto?.length;
   for(var i=0; i<logitud!; i++){
     ListaInstitutoM[ListaInstituto![i]['id_instituto']]; ListaInstituto![i]['nombre_instituto'];
      //print('===============FOR==============');

    }
   _dropValue =  ListaInstitutoM[ListaInstituto![0]['id_instituto']];
   // print('===============DROP==============');
   // print(_dropValue);
  }


  
  
  String dropdownValue = 'Seleccionar País';
String dropdownValue1 = 'Seleccionar Instituto';
String dropdownValuePais = 'Seleccionar Pais';



  TextEditingController cedulaEmpleadoController = TextEditingController();
  TextEditingController usernameEmpleadoController = TextEditingController();
  TextEditingController passwordEmpleadoController = TextEditingController();
  TextEditingController nameEmpleadoController = TextEditingController();
  TextEditingController apellidosEmpleadoController = TextEditingController();
  TextEditingController direccionEmpleadoController = TextEditingController();
  TextEditingController telefonoEmpleadoController = TextEditingController();
  TextEditingController emailEmpleadoController = TextEditingController();
  TextEditingController paisEmpleadoController = TextEditingController();
  TextEditingController fechaGradoEmpleadoController = TextEditingController();
  TextEditingController institutoEmpleadoController = TextEditingController();
  TextEditingController rolEmpleadoController = TextEditingController();

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

    paisEmpleadoController.text = dropdownValue;
    institutoEmpleadoController.text = selectedNameInstituto;
    fechaGradoEmpleadoController.text = DateFormat('yyyy-MM-dd').format(_dateTimeFechaGrado!);
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

    var url = Uri.parse('https://logistaff.electrosistem.com.co/LogiStaffApi/PhpFiles/registerPrestadorServicio.php');

    var response = await http.post(url, body: {

      "id_empleado": cedulaEmpleadoController.text,
      "username": usernameEmpleadoController.text,
      "password": passwordEmpleadoController.text,
      "nombres_empleado" : nameEmpleadoController.text,
      "apellidos_empleado": apellidosEmpleadoController.text,
      "direccion_empleado": direccionEmpleadoController.text,
      "telefono_empleado": telefonoEmpleadoController.text,
      "email_empleado": emailEmpleadoController.text,
      "pais_empleado": paisEmpleadoController.text,
      "fecha_grado_empleado": fechaGradoEmpleadoController.text,
      "id_instituto": institutoEmpleadoController.text,

    });

    var data = json.decode(response.body);

   // print('================== DATA ========================');
    //print(data);

    if (data == "Error") {
      Fluttertoast.showToast(
          msg: "Usuario Ya Existe",
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
                                Text('Registro Exitoso !!!!',
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



                    _textFieldCedula(),
                    //_textFieldUsername(),
                    _textFieldPassword(),
                    _textFieldNombres(),
                    _textFieldApellidos(),
                    _textFieldDireccion(),
                    _textFieldTelefono(),
                    _textFieldEmail(),
                    _dateFieldPickerFechaGrado(),
                    _dropFieldInstituto(),
                    _dropFieldPais(),

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


                  ],
                ),
              ),
            )
          ],


        ),
      ),
    );
  }


  Widget _textFieldCedula() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: cedulaEmpleadoController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Cédula',
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

  Widget _textFieldUsername() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: usernameEmpleadoController,

        decoration: InputDecoration(
            hintText: 'Usuario',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.person_pin_rounded,
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
        controller: passwordEmpleadoController,
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

  Widget _textFieldNombres() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: nameEmpleadoController,
        decoration: InputDecoration(
            hintText: 'Nombres',
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

  Widget _textFieldApellidos() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: apellidosEmpleadoController,
        decoration: InputDecoration(
            hintText: 'Apellidos',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.person_outline,
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
        controller: direccionEmpleadoController,

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

  Widget _textFieldTelefono() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: telefonoEmpleadoController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Teléfono',
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

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: emailEmpleadoController,
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

  Widget _dateFieldPickerFechaGrado(){
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 1, vertical: 4),
    decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)),
    child: TextButton(


      onPressed: () {
        showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1980),
            lastDate: DateTime(2030)
        ).then((date) {
          setState(() {
            _dateTimeFechaGrado = date;

          });
        });

      },
      child: Row(
        children: [
          const SizedBox(width: 5), // padding in the beginning
          Icon(Icons.date_range_sharp,
            color: MyColors.primaryColor,
          ), // the icon, or image, or whatever
          const SizedBox(width: 5), // padding in-between
          Text(_dateTimeFechaGrado == null ? 'Seleccione la Fecha de Grado' :  DateFormat('yyyy-MM-dd').format(_dateTimeFechaGrado!) ,
              style: TextStyle(
                  color: MyColors.primaryColorDark
              )
          ),


          // the text
        ],
      ),
    ),

  );
}

  Widget _dropFieldInstituto(){

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    decoration: BoxDecoration(
      color: MyColors.primaryOpacityColor,
      borderRadius: BorderRadius.circular(30),


    ),


    child: DropdownButton<String>(

      value: selectedNameInstituto,

      hint: dropdownValue1 == null ? Text("Seleccionar Instituto",  style: TextStyle(color: Colors.black), ): Text(dropdownValue1, style: TextStyle(color: MyColors.primaryColorDark)),
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
          selectedNameInstituto = value;
          print(selectedNameInstituto);
        });
      },

      items: data?.map((list) {
        return DropdownMenuItem<String>(
          value: list['id_instituto'],
          child: Row(
            children: [
              Icon(Icons.business_rounded,
                color: MyColors.primaryColor,),
              Padding(padding: EdgeInsets.all(3)) ,
              Text(list['nombre_instituto']),
            ],
          ),
        );
      }).toList(),
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


        if(cedulaEmpleadoController.text.isEmpty || passwordEmpleadoController.text.isEmpty || nameEmpleadoController.text.isEmpty
            || apellidosEmpleadoController.text.isEmpty || direccionEmpleadoController.text.isEmpty || telefonoEmpleadoController.text.isEmpty || emailEmpleadoController.text.isEmpty
            || selectedNamePais == null || _dateTimeFechaGrado == null || selectedNameInstituto  == null){

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
        width: 270,
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
                  "REGISTRO PRESTADOR DE SERVICIO",
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