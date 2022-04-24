import 'package:flutter/cupertino.dart';


class BackgroundRol extends StatelessWidget {
  final Widget child;

  const BackgroundRol({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

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
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                "assets/images/bottom01.png",
                width: size.width
            ),
          ),

          child
        ],
      ),
    );
  }
}