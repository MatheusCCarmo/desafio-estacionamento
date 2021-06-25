import 'dart:ui';

import 'package:estacionamento/model/entrada.dart';
import 'package:estacionamento/model/vaga.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class VagaWidget extends StatefulWidget {
  final Vaga vaga;

  const VagaWidget({Key? key, required this.vaga}) : super(key: key);

  @override
  _VagaWidgetState createState() => _VagaWidgetState();
}

class _VagaWidgetState extends State<VagaWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: widget.vaga.isVacant
              ? [AppColors.vacant, AppColors.confirm]
              : [AppColors.occupied, AppColors.delete],
        ),
        borderRadius: BorderRadius.circular(5),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            widget.vaga.id,
            textAlign: TextAlign.center,
            style: AppTextStyles.titleRegular,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.drive_eta,
                color: AppColors.white,
              ),
              Text(
                widget.vaga.veicle,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyRegular,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
