import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:todoapp/screens/screens.dart';
import 'package:todoapp/theme.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => MyTodo(),
    ),
  );
}

class MyTodo extends StatelessWidget {
  MyTodo({Key? key}) : super(key: key);
  final ThemeData theme = TodoTheme.light();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To Do App",
      theme: theme,
      home: const Homepage(),
    );
  }
}
