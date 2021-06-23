import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class VagaWidget extends StatelessWidget {
  const VagaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Dismissible(
      key: ObjectKey(key),
      direction: DismissDirection.endToStart,
      child: Container(
        width: size.width * 0.8,
        height: 60,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey,
              offset: Offset(0, 0),
              spreadRadius: 3,
              blurRadius: 4,
            ),
          ],
        ),
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Text('teste'),
                  Text('teste'),
                ],
              ),
              Row(
                children: [
                  Text('teste'),
                  Text('teste'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
