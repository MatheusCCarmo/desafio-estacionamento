import 'package:estacionamento/modules/historico/historico_page.dart';
import 'package:estacionamento/modules/entradas/entradas_page.dart';
import 'package:estacionamento/modules/vagas/vagas_page.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:estacionamento/shared/widgets/tab_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
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
      home: SafeArea(
        child: TabNavigation(),
      ),
    );
  }
}
