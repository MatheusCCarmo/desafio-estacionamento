import 'package:estacionamento/model/entrada.dart';
import 'package:estacionamento/model/vaga.dart';
import 'package:estacionamento/modules/entradas/entrada_widget.dart';
import 'package:estacionamento/shared/store/store.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:estacionamento/shared/widgets/add_button.dart';
import 'package:estacionamento/shared/widgets/form_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EntradasPage extends StatefulWidget {
  const EntradasPage({Key? key}) : super(key: key);

  @override
  _EntradasPageState createState() => _EntradasPageState();
}

class _EntradasPageState extends State<EntradasPage> {
  final TextEditingController vagaIdController = TextEditingController();
  final TextEditingController entradaVeicleController = TextEditingController();
  final TextEditingController entradaEntryTimeController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Entrada> _entradas = [];

  @override
  void initState() {
    _entradas = Store.entradas;
    super.initState();
  }

  @override
  void dispose() {
    vagaIdController.dispose();
    entradaVeicleController.dispose();
    entradaEntryTimeController.dispose();
    super.dispose();
  }

  Future<bool> _showAlertForm() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: 450,
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
                          'Adicionar Entrada',
                          style: AppTextStyles.heading1,
                        ),
                        FormFieldWidget(
                          fieldDescription: 'Identificação da Vaga',
                          controller: vagaIdController,
                          hintText: 'Ex: 02, A1...',
                        ),
                        FormFieldWidget(
                            fieldDescription: 'Identificação do Veículo',
                            controller: entradaVeicleController,
                            hintText: 'Ex: JLK-1265, KMT 2067'),
                        FormFieldWidget(
                          fieldDescription: 'Horário de Entrada',
                          controller: entradaEntryTimeController,
                          hintText: 'Ex: 09:40, meio-dia',
                        ),
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
      },
    );
  }

  _createEntrada() async {
    bool confirm = await _showAlertForm();
    if (!confirm) return;

    Vaga vaga = Vaga(
      id: vagaIdController.text,
      veicle: entradaVeicleController.text,
      isVacant: false,
    );
    Entrada entrada = Entrada(
      vaga: vaga,
      veicle: entradaVeicleController.text,
      entryTime: entradaEntryTimeController.text,
    );

    setState(() {
      Store.addEntrada(entrada);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.background,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size.width * 0.85,
            child: ListView.builder(
              dragStartBehavior: DragStartBehavior.down,
              itemCount: _entradas.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 12),
                  child: EntradaWidget(
                      entrada: _entradas[_entradas.length - index - 1]),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AddButton(
              buttonTitle: 'Adicionar Entrada',
              onTapFunction: _createEntrada,
            ),
          )
        ],
      ),
    );
  }
}
