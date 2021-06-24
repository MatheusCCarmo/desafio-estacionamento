import 'package:estacionamento/model/vaga.dart';
import 'package:estacionamento/modules/vagas/vaga_widget.dart';
import 'package:estacionamento/shared/store/store.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
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
        return AlertDialog(
          title: Text('Adicionar Vaga'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Salvar'),
            ),
          ],
          content: Container(
            height: 130,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FormFieldWidget(
                    fieldDescription: 'Nome ou número da vaga',
                    controller: vagaIdController,
                  ),
                ],
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
                return VagaWidget(vaga: _vagas[index]);
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
