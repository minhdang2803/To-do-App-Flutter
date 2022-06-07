import 'package:flutter/material.dart';
import 'package:todoapp/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(image: AssetImage('assets/logo.png')),
        const SizedBox(height: 8),
        Text(
          'What To Doooo!',
          style: TodoTheme.lightTextTheme.headline1,
        )
      ],
    ));
  }
}
