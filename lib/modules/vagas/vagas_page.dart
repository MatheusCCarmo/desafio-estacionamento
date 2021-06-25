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
  TextEditingController _vagaIdController = TextEditingController();
  TextEditingController _buscaController = TextEditingController();

  late List<Vaga> _vagas;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _vagas = Store.vagasFiltradas;
    super.initState();
  }

  @override
  void dispose() {
    _vagaIdController.dispose();
    super.dispose();
  }

  searchVaga() {
    setState(() {
      Store.filter = _buscaController.text;
      _vagas = Store.vagasFiltradas;
    });
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
                          controller: _vagaIdController,
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

    Vaga vaga = Vaga(id: _vagaIdController.text);

    setState(() {
      Store.addVaga(vaga);
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
                SliverAppBar(
                  title: Text(
                    'Vagas',
                    style: AppTextStyles.titleRegularWhite,
                  ),
                ),
                SliverAppBar(
                  pinned: true,
                  elevation: 1,
                  toolbarHeight: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  flexibleSpace: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: _buscaController,
                        onChanged: searchVaga(),
                        style: AppTextStyles.body2RegularWhite,
                        decoration: InputDecoration(
                          prefixIconConstraints: BoxConstraints.tight(
                            Size(35, 30),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.white,
                            size: 22,
                          ),
                          hintText: 'Procurar',
                          hintStyle: TextStyle(
                            color: AppColors.white,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
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
                )
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
