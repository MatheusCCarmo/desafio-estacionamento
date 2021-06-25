import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:estacionamento/shared/widgets/form_field_widget.dart';
import 'package:flutter/material.dart';

class AlertFormWidget extends StatefulWidget {
  final String title;
  final List<FormFieldWidget> formFields;
  const AlertFormWidget({
    Key? key,
    required this.title,
    required this.formFields,
  }) : super(key: key);

  @override
  _AlertFormWidgetState createState() => _AlertFormWidgetState();
}

class _AlertFormWidgetState extends State<AlertFormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: 160.0 + (70 * widget.formFields.length),
        width: 300,
        child: Container(
          child: Center(
            child: Form(
              key: _formKey,
              child: Container(
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: AppTextStyles.heading1,
                    ),
                    ...widget.formFields,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).pop(true);
                            }
                          },
                          child: Text('Confirmar'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
