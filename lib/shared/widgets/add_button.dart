import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function onTapFunction;
  final String buttonTitle;
  const AddButton(
      {Key? key, required this.onTapFunction, required this.buttonTitle})
      : super(key: key);

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
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                buttonTitle,
                style: AppTextStyles.buttonRegularWhite,
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
