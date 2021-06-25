import 'package:estacionamento/model/vaga.dart';
import 'package:estacionamento/modules/vagas/vaga_widget.dart';
import 'package:estacionamento/shared/store/store.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:estacionamento/shared/widgets/add_button.dart';
import 'package:estacionamento/shared/widgets/form_field_widget.dart';
import 'package:flutter/material.dart';

class VagasPage extends StatefulWidget {
  const VagasPage({Key? key}) : super(key: key);

  @override
  _VagasPageState createState() => _VagasPageState();
}

class _VagasPageState extends State<VagasPage> {
  TextEditingController vagaIdController = TextEditingController();
  late List<Vaga> _vagas;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _vagas = Store.vagas;
    super.initState();
  }

  @override
  void dispose() {
    vagaIdController.dispose();
    super.dispose();
  }

  @override
  Future<bool> _showAlertForm() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: 250,
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
                          'Adicionar Vaga',
                          style: AppTextStyles.heading1,
                        ),
                        FormFieldWidget(
                          fieldDescription: 'Identificação da Nova Vaga',
                          controller: vagaIdController,
                          hintText: 'Ex: 02, A1...',
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

  _createVaga() async {
    bool confirm = await _showAlertForm();
    if (!confirm) return;

    Vaga vaga = Vaga(id: vagaIdController.text);

    setState(() {
      Store.addVaga(vaga);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      color: AppColors.background,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size.width * 0.90,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
              ),
              itemCount: _vagas.length,
              itemBuilder: (context, index) {
                return VagaWidget(vaga: _vagas[_vagas.length - index - 1]);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AddButton(
              buttonTitle: 'Adicionar Vaga',
              onTapFunction: _createVaga,
            ),
          )
        ],
      ),
    );
  }
}
