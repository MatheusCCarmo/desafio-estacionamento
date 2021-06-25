import 'package:estacionamento/model/entrada.dart';
import 'package:estacionamento/model/vaga.dart';
import 'package:estacionamento/modules/entradas/entrada_widget.dart';
import 'package:estacionamento/shared/store/store.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:estacionamento/shared/widgets/add_button.dart';
import 'package:estacionamento/shared/widgets/alert_form_widget.dart';
import 'package:estacionamento/shared/widgets/form_field_widget.dart';
import 'package:estacionamento/shared/widgets/sliver_app_bar_widget.dart';
import 'package:estacionamento/shared/widgets/sliver_search_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EntradasPage extends StatefulWidget {
  const EntradasPage({Key? key}) : super(key: key);

  @override
  _EntradasPageState createState() => _EntradasPageState();
}

class _EntradasPageState extends State<EntradasPage> {
  final TextEditingController _vagaIdController = TextEditingController();
  final TextEditingController _entradaVeicleController =
      TextEditingController();
  final TextEditingController _entradaEntryTimeController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late List<FormFieldWidget> formFields;

  List<Entrada> _entradas = [];

  @override
  void initState() {
    _entradas = Store.entradas;
    formFields = [
      FormFieldWidget(
        fieldDescription: 'Identificação da Vaga',
        controller: _vagaIdController,
        hintText: 'Ex: 02, A1...',
      ),
      FormFieldWidget(
        fieldDescription: 'Identificação do Veículo',
        controller: _entradaVeicleController,
        hintText: 'Ex: JLK-1265, KMT 2067',
      ),
      FormFieldWidget(
        fieldDescription: 'Horário de Entrada',
        controller: _entradaEntryTimeController,
        hintText: 'Ex: 09:40, meio-dia',
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _vagaIdController.dispose();
    _entradaVeicleController.dispose();
    _entradaEntryTimeController.dispose();
    super.dispose();
  }

  Future<bool> _showAlertForm() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertFormWidget(
            title: 'Adicionar Entrada', formFields: formFields);
      },
    );
  }

  Future<bool> _deleteDialog(BuildContext context, Entrada entrada) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Excluir essa entrada?'),
          content: Text(
              'A entrada será excluída da página de entradas, mas estará presente no seu histórico.'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                setState(() {
                  Store.removeEntrada(entrada);
                });
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  _createEntrada() async {
    bool confirm = await _showAlertForm();
    if (!confirm) return;

    Vaga vaga = Vaga(
      id: _vagaIdController.text,
      veicle: _entradaVeicleController.text,
      isVacant: false,
    );
    Entrada entrada = Entrada(
      vaga: vaga,
      veicle: _entradaVeicleController.text,
      entryTime: _entradaEntryTimeController.text,
    );

    setState(() {
      Store.addEntrada(entrada);
    });
  }

  _searchEntrada(value) {
    setState(() {
      Store.filter = value;
      _entradas = Store.entradasFiltradas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: CustomScrollView(
              slivers: [
                SliverAppBarWidget(title: 'Entrada'),
                SliverSearchWidget(searchCallback: _searchEntrada),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(top: 12, left: 20, right: 20),
                        child: EntradaWidget(
                            entrada: _entradas[_entradas.length - index - 1],
                            deleteCallback: _deleteDialog),
                      );
                    },
                    childCount: _entradas.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                  ),
                ),
              ],
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
