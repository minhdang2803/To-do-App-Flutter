import 'package:flutter/material.dart';

class Task {
  int? id;
  String? chipLabel;
  Color? backgroundColor;
  String? title;
  String? description;
  String? contextInside;

  Task(
      {this.backgroundColor,
      this.chipLabel,
      this.title,
      this.contextInside,
      this.description,
      this.id});
}
