import 'dart:ui';

import 'package:estacionamento/model/vaga.dart';
import 'package:estacionamento/shared/store/store.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class VagaWidget extends StatelessWidget {
  final Vaga vaga;
  final Function onTapCallback;

  const VagaWidget({Key? key, required this.vaga, required this.onTapCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapCallback(vaga);
      },
      child: Container(
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: vaga.isVacant
                ? [AppColors.vacantLight, AppColors.white]
                : [AppColors.occupiedLight, AppColors.white],
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
            Expanded(
              child: Text(
                vaga.id,
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2Regular,
                overflow: TextOverflow.fade,
              ),
            ),
            Container(
              decoration: ShapeDecoration(
                color: vaga.isVacant
                    ? AppColors.vacantLight
                    : AppColors.occupiedLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Icon(
                      Icons.drive_eta,
                      color: AppColors.heading,
                      size: 16,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Text(
                      vaga.veicle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.captionRegular,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
