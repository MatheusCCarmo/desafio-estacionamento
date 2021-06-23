import 'package:estacionamento/modules/historico/historico_page.dart';
import 'package:estacionamento/modules/vagas/vagas_page.dart';
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
      home: SafeArea(
        child: AppNavigation(),
      ),
    );
  }
}

class AppNavigation extends StatefulWidget {
  const AppNavigation({Key? key}) : super(key: key);

  @override
  _AppNavigationState createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = [
    VagasPage(),
    HistoricoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Vagas',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Histórico',
            icon: Icon(Icons.list),
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
      ),
    );
  }
}
