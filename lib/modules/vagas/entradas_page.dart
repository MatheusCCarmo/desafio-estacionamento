import 'package:estacionamento/model/vaga.dart';
import 'package:estacionamento/modules/vagas/entrada_widget.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/widgets/add_button.dart';
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
  List<Vaga> _vagas = [
    Vaga(id: 'A1'),
  ];

  Widget formField(String fieldDescription, TextEditingController controller) {
    return Container(
      child: Column(
        children: [
          Text(fieldDescription),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextField(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }

  _showAlertForm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Entrada'),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Salvar'),
            ),
          ],
          content: Container(
            height: 230,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  formField('Nome ou número da vaga', vagaIdController),
                  formField(
                      'Veículo que entrou na vaga', entradaVeicleController),
                  formField('Horário de Entrada', entradaEntryTimeController),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  adicionarEntrada() {
    _showAlertForm();
    // Vaga vaga = Vaga();
    // setState(() {
    //   _vagas.add(vaga);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size.width * 0.85,
            child: ListView.builder(
              itemCount: _vagas.length,
              itemBuilder: (context, index) {
                return EntradaWidget(vaga: _vagas[index]);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AddButton(
              addEntrada: adicionarEntrada,
            ),
          )
        ],
      ),
    );
  }
}
