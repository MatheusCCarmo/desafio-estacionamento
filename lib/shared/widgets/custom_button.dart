import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onTapFunction;
  final String title;
  final Color color;
  final IconData icon;
  const CustomButton({
    Key? key,
    required this.onTapFunction,
    required this.title,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          onTapFunction();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey,
                offset: Offset(0, 0),
                spreadRadius: 1,
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTextStyles.buttonRegularWhite,
              ),
              Icon(
                icon,
                color: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
