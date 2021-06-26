import 'package:estacionamento/model/entrada.dart';
import 'package:estacionamento/modules/historico/historico_widget.dart';
import 'package:estacionamento/shared/store/store.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/widgets/custom_button.dart';
import 'package:estacionamento/shared/widgets/sliver_app_bar_widget.dart';
import 'package:estacionamento/shared/widgets/sliver_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({Key? key}) : super(key: key);

  @override
  _HistoricoPageState createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  List<Entrada> _historico = [];

  @override
  void initState() {
    Store.loadHistorico();
    _historico = Store.historico;
    super.initState();
  }

  _searchHistorico(value) {
    setState(() {
      Store.filter = value;
      _historico = Store.historicoFiltrado;
    });
  }

  _limparHistorico() async {
    bool confirm = await _showAlertLimpar();
    if (!confirm) return;

    setState(() {
      Store.limparHistorico();
      _historico = Store.historico;
    });
  }

  _showAlertLimpar() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Deseja limpar o histórico?'),
          content: Text('Você não terá mais acesso a esses dados.'),
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
                SliverAppBarWidget(title: 'Histórico'),
                SliverSearchWidget(searchCallback: _searchHistorico),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(top: 12, left: 20, right: 20),
                        child: HistoricoWidget(
                          entrada: _historico[_historico.length - index - 1],
                        ),
                      );
                    },
                    childCount: _historico.length,
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
                CustomButton(
                  title: 'Limpar Histórico',
                  onTapFunction: _limparHistorico,
                  icon: Icons.delete,
                  color: AppColors.delete,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
