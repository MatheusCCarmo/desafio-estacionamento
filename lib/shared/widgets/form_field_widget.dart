import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  final String fieldDescription;
  final TextEditingController controller;
  const FormFieldWidget(
      {Key? key, required this.fieldDescription, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = '';
    return Container(
      child: Column(
        children: [
          Text(fieldDescription),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextField(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
