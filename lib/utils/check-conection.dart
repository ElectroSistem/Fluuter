/**
 * Author: Robinson Herrera
 * profile: https://electrosistem.com.co
 */

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';



class CheckConection {
  CheckConection(variable);



  _checkInternet() async
  {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
      print("========I am connected to a mobile network.");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
      print("=========I am connected to a wifi network.");
    }
    else
    {
     return false;
      print("===========No internet connection!");



          }

    }


  }






