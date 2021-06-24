import 'package:estacionamento/model/entrada.dart';
import 'package:estacionamento/model/vaga.dart';
import 'package:estacionamento/modules/entradas/entrada_widget.dart';
import 'package:estacionamento/shared/store/store.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/widgets/add_button.dart';
import 'package:estacionamento/shared/widgets/form_field_widget.dart';
import 'package:flutter/material.dart';

class EntradasPage extends StatefulWidget {
  const EntradasPage({Key? key}) : super(key: key);

  @override
  _EntradasPageState createState() => _EntradasPageState();
}

class _EntradasPageState extends State<EntradasPage> {
  TextEditingController vagaIdController = TextEditingController();
  TextEditingController entradaVeicleController = TextEditingController();
  TextEditingController entradaEntryTimeController = TextEditingController();
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
        return AlertDialog(
          title: Text('Adicionar Entrada'),
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
            height: 230,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FormFieldWidget(
                      fieldDescription: 'Nome ou número da vaga',
                      controller: vagaIdController),
                  FormFieldWidget(
                      fieldDescription: 'Veículo que entrou na vaga',
                      controller: entradaVeicleController),
                  FormFieldWidget(
                      fieldDescription: 'Horário de Entrada',
                      controller: entradaEntryTimeController),
                ],
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

    Vaga vaga = Vaga(id: vagaIdController.text);
    Entrada entrada = Entrada(
      vaga: vaga,
      veicle: entradaVeicleController.text,
      entryTime: entradaEntryTimeController.text,
    );
    setState(() {
      _entradas.add(entrada);
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
              itemCount: _entradas.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.only(top: 12),
                    child: EntradaWidget(entrada: _entradas[index]));
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
