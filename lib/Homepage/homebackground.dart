import 'package:flutter/material.dart';

class HomeBackground extends StatelessWidget {
  final Widget child;
  
  const HomeBackground({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override 
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: SafeArea(
        child:Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
              "assets/images/top3.png",
              width: size.width,
            ),
            ),
          ),

          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
              "assets/images/bottom5.png",
              width: size.width
              ),
            ),
          ),
          child
        ],
      ),
      ),
    );
  }
}