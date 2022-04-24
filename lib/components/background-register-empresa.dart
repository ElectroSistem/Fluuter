import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundRegisterEmpresa extends StatelessWidget {
  final Widget child;

  const BackgroundRegisterEmpresa({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[


          Positioned(
            top: 40,
            right: 10,
            child: Image.asset(
                "assets/images/main.png",
                width: size.width * 0.45
            ),
          ),


          child
        ],
      ),
    );
  }
}
