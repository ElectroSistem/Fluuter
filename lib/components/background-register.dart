import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundRegister extends StatelessWidget {
  final Widget child;

  const BackgroundRegister({
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
            top: 50,
            right: 30,
            child: Image.asset(
                "assets/images/main.png",
                width: size.width * 0.35
            ),
          ),


          child
        ],
      ),
    );
  }
}
