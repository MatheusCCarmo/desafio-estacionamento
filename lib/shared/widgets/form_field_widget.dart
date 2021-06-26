import 'package:estacionamento/shared/store/store.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  final String fieldDescription;
  final TextEditingController controller;
  final String hintText;

  const FormFieldWidget({
    Key? key,
    required this.fieldDescription,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = '';
    return Container(
      child: Column(
        children: [
          Text(fieldDescription),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextFormField(
              controller: controller,
              cursorColor: AppColors.primary,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 14),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha o campo!';
                }

                int itemIndex =
                    Store.vagas.indexWhere((element) => element.id == value);

                if (itemIndex != -1 &&
                    !Store.vagas.elementAt(itemIndex).isVacant &&
                    fieldDescription == 'Identificação da Vaga') {
                  return 'Esta vaga já está ocupada!';
                }

                if (itemIndex != -1 &&
                    fieldDescription == 'Identificação da Nova Vaga') {
                  return 'Esta vaga já existe!';
                }

                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
