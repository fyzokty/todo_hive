// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum TaskColor {
  DEFAULT(color: Colors.transparent),
  WHITE(color: Colors.white),
  RED(color: Colors.red),
  PINK(color: Colors.pink),
  PURPLE(color: Colors.purple),
  BLUE(color: Colors.blue),
  CYAN(color: Colors.cyan),
  GREEN(color: Colors.green),
  YELLOW(color: Colors.yellow),
  GREY(color: Colors.grey);

  final Color color;
  const TaskColor({required this.color});
}
