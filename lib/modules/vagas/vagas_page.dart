import 'package:estacionamento/model/vaga.dart';
import 'package:estacionamento/modules/vagas/vaga_widget.dart';
import 'package:estacionamento/shared/store/store.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/widgets/add_button.dart';
import 'package:estacionamento/shared/widgets/alert_form_widget.dart';
import 'package:estacionamento/shared/widgets/form_field_widget.dart';
import 'package:estacionamento/shared/widgets/sliver_app_bar_widget.dart';
import 'package:estacionamento/shared/widgets/sliver_search_widget.dart';
import 'package:flutter/material.dart';

class VagasPage extends StatefulWidget {
  const VagasPage({Key? key}) : super(key: key);

  @override
  _VagasPageState createState() => _VagasPageState();
}

class _VagasPageState extends State<VagasPage> {
  TextEditingController _vagaIdController = TextEditingController();
  late List<FormFieldWidget> formFields;

  late List<Vaga> _vagas;

  @override
  void initState() {
    _vagas = Store.vagas;
    formFields = [
      FormFieldWidget(
        fieldDescription: 'Identificação da Nova Vaga',
        controller: _vagaIdController,
        hintText: 'Ex: 02, A1...',
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _vagaIdController.dispose();
    super.dispose();
  }

  Future<bool> _showAlertForm() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertFormWidget(title: 'Adicionar Vaga', formFields: formFields);
      },
    );
  }

  _createVaga() async {
    bool confirm = await _showAlertForm();
    if (!confirm) return;

    Vaga vaga = Vaga(id: _vagaIdController.text);

    setState(() {
      Store.addVaga(vaga);
    });
  }

  _searchVaga(String filter) {
    setState(() {
      Store.filter = filter;
      _vagas = Store.vagasFiltradas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.background,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: CustomScrollView(
              slivers: [
                SliverAppBarWidget(title: 'Vagas'),
                SliverSearchWidget(searchCallback: _searchVaga),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return VagaWidget(
                        vaga: _vagas[_vagas.length - index - 1],
                      );
                    },
                    childCount: _vagas.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
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
              buttonTitle: 'Adicionar Vaga',
              onTapFunction: _createVaga,
            ),
          )
        ],
      ),
    );
  }
}
