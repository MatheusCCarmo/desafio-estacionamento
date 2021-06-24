import 'package:estacionamento/modules/historico/historico_page.dart';
import 'package:estacionamento/modules/entradas/entradas_page.dart';
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
        child: TabNavigation(),
      ),
    );
  }
}

class TabNavigation extends StatefulWidget {
  const TabNavigation({Key? key}) : super(key: key);

  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = [
    VagasPage(),
    EntradasPage(),
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
            icon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            label: 'Entradas',
            icon: Icon(Icons.list),
          ),
          BottomNavigationBarItem(
            label: 'Histórico',
            icon: Icon(Icons.history),
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
      ),
    );
  }
}
