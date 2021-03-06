import 'package:estacionamento/modules/entradas/entradas_page.dart';
import 'package:estacionamento/modules/historico/historico_page.dart';
import 'package:estacionamento/modules/vagas/vagas_page.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: AppColors.primary,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.transparentGrey,
      ),
    );
  }
}
