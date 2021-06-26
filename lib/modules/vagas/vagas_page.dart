import 'package:estacionamento/model/vaga.dart';
import 'package:estacionamento/modules/vagas/vaga_widget.dart';
import 'package:estacionamento/shared/store/store.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_images.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:estacionamento/shared/widgets/custom_button.dart';
import 'package:estacionamento/shared/widgets/alert_form_widget.dart';
import 'package:estacionamento/shared/widgets/form_field_widget.dart';
import 'package:estacionamento/shared/widgets/sliver_app_bar_widget.dart';
import 'package:estacionamento/shared/widgets/sliver_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

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
    Store.loadVagas();
    _vagas = Store.vagas;
    formFields = [
      FormFieldWidget(
          fieldDescription: 'Identificação da Nova Vaga',
          controller: _vagaIdController,
          hintText: 'Ex: 02, A1...'),
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

    Vaga vaga = Vaga(id: _vagaIdController.text.trim().toUpperCase());

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

  _showVagaDialog(vaga) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Deseja excluir a vaga "${vaga.id}"?'),
          content: Text(
            vaga.isVacant
                ? ''
                : 'Você não pode excluir uma vaga que está ocupada! Registre a saída ou exclua a entrada correspondente para conseguir excluir esta vaga.',
            style: AppTextStyles.body2RegularError,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (vaga.isVacant) {
                  setState(() {
                    Store.removeVaga(vaga);
                  });
                  Navigator.of(context).pop(true);
                }
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  _limparVagas() async {
    bool confirm = await _showAlertLimpar();
    if (!confirm) return;

    setState(() {
      Store.limparVagasVazias();
      _vagas = Store.vagas;
    });
  }

  _showAlertLimpar() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Deseja excluir todas as vagas vazias?'),
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
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  _cautionHandler() {
    setState(() {
      GetStorage().erase();
      Store.loadVagas();
      _vagas = Store.vagas;
    });
  }

  _sortHandler() {
    setState(() {
      Store.sortVagas();
      _vagas = Store.vagas;
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
          Image.asset(
            AppImages.backgroundImage,
            fit: BoxFit.cover,
            color: AppColors.transparentGrey,
          ),
          Container(
            child: CustomScrollView(
              slivers: [
                SliverAppBarWidget(
                  title: 'Vagas',
                  cautionHandler: _cautionHandler,
                  sortHandler: _sortHandler,
                ),
                SliverSearchWidget(searchCallback: _searchVaga),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return VagaWidget(
                        vaga: _vagas[index],
                        onTapCallback: _showVagaDialog,
                      );
                    },
                    childCount: _vagas.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.8,
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
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _vagas.length > 0
                    ? CustomButton(
                        title: 'Limpar Vagas',
                        onTapFunction: _limparVagas,
                        icon: Icons.delete,
                        color: AppColors.delete,
                      )
                    : SizedBox(
                        height: 40,
                      ),
                CustomButton(
                  title: 'Adicionar Vaga',
                  color: AppColors.primary,
                  icon: Icons.add,
                  onTapFunction: _createVaga,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
