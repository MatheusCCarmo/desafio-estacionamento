import 'package:estacionamento/model/entrada.dart';
import 'package:estacionamento/shared/store/store.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:estacionamento/shared/widgets/alert_form_widget.dart';
import 'package:estacionamento/shared/widgets/entrada_info_widget.dart';
import 'package:estacionamento/shared/widgets/form_field_widget.dart';
import 'package:flutter/material.dart';

class EntradaWidget extends StatefulWidget {
  final Entrada entrada;
  final Function deleteCallback;

  const EntradaWidget({
    Key? key,
    required this.entrada,
    required this.deleteCallback,
  }) : super(key: key);

  @override
  _EntradaWidgetState createState() => _EntradaWidgetState();
}

class _EntradaWidgetState extends State<EntradaWidget> {
  TextEditingController _exitTimeController = TextEditingController();
  late List<FormFieldWidget> formFields;

  @override
  void initState() {
    formFields = [
      FormFieldWidget(
        fieldDescription: 'Horário de Saída',
        controller: _exitTimeController,
        hintText: 'Ex: 17:40, 15 horas...',
      ),
    ];
    super.initState();
  }

  Future<bool> _showAlertForm() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertFormWidget(
            title: 'Registrar Saída', formFields: formFields);
      },
    );
  }

  _registrarSaida() async {
    bool confirm = await _showAlertForm();
    if (!confirm) return;

    setState(() {
      Store.registrarSaida(widget.entrada, _exitTimeController.text.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: AppColors.delete,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          margin: EdgeInsets.only(right: 12),
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            size: 40,
            color: AppColors.white,
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        return await widget.deleteCallback(context, widget.entrada);
      },
      child: Container(
        height: 135,
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
            EntradaInfoWidget(entrada: widget.entrada),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    widget.deleteCallback(context, widget.entrada);
                  },
                  child: Container(
                    height: 34,
                    width: 130,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.delete,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      'Excluir Entrada',
                      style: AppTextStyles.buttonRegularWhite,
                    ),
                  ),
                ),
                InkWell(
                  onTap: _registrarSaida,
                  child: Container(
                    height: 34,
                    width: 130,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      'Registrar Saída',
                      style: AppTextStyles.buttonRegularWhite,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
