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
  final TextEditingController _vagaIdController = TextEditingController();
  final TextEditingController _entradaVeicleController =
      TextEditingController();
  final TextEditingController _entradaEntryTimeController =
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
    _vagaIdController.dispose();
    _entradaVeicleController.dispose();
    _entradaEntryTimeController.dispose();
    super.dispose();
  }

  Future<bool> _showAlertForm() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
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
                          controller: _vagaIdController,
                          hintText: 'Ex: 02, A1...',
                        ),
                        FormFieldWidget(
                            fieldDescription: 'Identificação do Veículo',
                            controller: _entradaVeicleController,
                            hintText: 'Ex: JLK-1265, KMT 2067'),
                        FormFieldWidget(
                          fieldDescription: 'Horário de Entrada',
                          controller: _entradaEntryTimeController,
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

  searchEntrada(value) {
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
                SliverAppBar(
                  title: Text(
                    'Entradas',
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
                        onChanged: (value) {
                          searchEntrada(value);
                        },
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
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(top: 12, left: 20, right: 20),
                        child: EntradaWidget(
                            entrada: _entradas[_entradas.length - index - 1]),
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
