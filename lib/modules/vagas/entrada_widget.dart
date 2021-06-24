import 'package:estacionamento/model/vaga.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class EntradaWidget extends StatelessWidget {
  final Vaga vaga;

  const EntradaWidget({
    Key? key,
    required this.vaga,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(key),
      direction: DismissDirection.endToStart,
      child: Container(
        height: 60,
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey,
              offset: Offset(0, 0),
              spreadRadius: 1.5,
              blurRadius: 3.5,
            ),
          ],
        ),
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                    children: [
                      Text('teste'),
                      Text('teste'),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: AppColors.delete,
                  height: double.infinity,
                  child: Icon(Icons.delete),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
