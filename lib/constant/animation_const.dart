import 'package:flutter/material.dart';

class AnimationConst {
  static const _transition = Duration(milliseconds: 800);
  static const _reverseTransition = Duration(milliseconds: 400);
  static const _animation = Duration(milliseconds: 300);
  static const _reverseAnimation = Duration(milliseconds: 200);
  static const _curve = Curves.fastOutSlowIn;

  static Duration get transition => _transition;
  static Duration get reverseTransition => _reverseTransition;
  static Duration get animation => _animation;
  static Duration get reverseAnimation => _reverseAnimation;
  static Curve get curve => _curve;
}
