import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estacionamento',
      theme: ThemeData(
          primaryColor: AppColors.primary,
          textTheme: TextTheme(
            headline1: AppTextStyles.titleRegular,
          )),
      home: Container(),
    );
  }
}
