import 'package:estacionamento/model/entrada.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/widgets/entrada_info_widget.dart';
import 'package:flutter/material.dart';

class HistoricoWidget extends StatelessWidget {
  final Entrada entrada;
  const HistoricoWidget({Key? key, required this.entrada}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyShadow,
            offset: Offset(1, 1),
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          EntradaInfoWidget(entrada: entrada),
        ],
      ),
    );
  }
}
