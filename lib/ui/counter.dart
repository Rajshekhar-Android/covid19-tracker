import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Counter extends AnimatedWidget {
  Counter({Key key, this.animation, this.textStyle}) : super(key: key, listenable: animation);
  final Animation<int> animation;
  final TextStyle textStyle;

  @override
  build(BuildContext context) {
    return new Text(
      animation.value.toString(),
      style: textStyle,
    );
  }
}