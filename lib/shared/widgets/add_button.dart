import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function addEntrada;
  const AddButton({Key? key, required this.addEntrada}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          addEntrada();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Adicionar Entrada",
                style: AppTextStyles.titleRegularWhite,
              ),
              Icon(
                Icons.add,
                color: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
