import 'package:flutter/material.dart';

class JumpingLogo extends AnimatedWidget {
  JumpingLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      height: animation.value,
      child: Image.asset("images/t3chfest-logo.png"),
    );
  }
}