import 'package:flutter/material.dart';
import 'package:logisticaduran/Screens/Empleado/home-empleado.dart';
import 'package:logisticaduran/Screens/Empleado/perfil-empleado.dart';
import 'package:logisticaduran/Screens/Empresa/home-empresa.dart';
import 'package:logisticaduran/Screens/Instituto/home-instituto.dart';
import 'package:logisticaduran/Screens/register/register-empresas.dart';
import 'package:logisticaduran/Screens/register/register-instituto.dart';
import 'package:logisticaduran/Screens/register/register-prestador.dart';
import 'package:logisticaduran/roles-page.dart';

import 'Screens/Administrador/home-admin.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/login' : (context) => Login(),
      '/register-prestador' : (context) => Register(),
      '/register-empresa' : (context) => RegisterEmpresa(),
      '/register-instituto' : (context) => RegisterInstituto(),
      '/homeadmin' : (context) => Homeadmin('','','','',''),
      '/home-empleado' : (context) => HomeEmpleado('','','','',''),
      '/home-empresa' : (context) => HomeEmpresa(),
      '/home-instituto' : (context) => HomeInstituto(),
      '/roles-page' : (context) => RolesPage(),
      '/perfil-page' : (context) => PerfilEmpleado('','','','',''),




    },
    initialRoute: '/login',
  ));
}
