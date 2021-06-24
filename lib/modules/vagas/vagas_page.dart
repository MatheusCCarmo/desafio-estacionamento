import 'package:estacionamento/model/vaga.dart';
import 'package:estacionamento/modules/vagas/vaga_widget.dart';
import 'package:estacionamento/shared/widgets/add_button.dart';
import 'package:flutter/material.dart';

class VagasPage extends StatefulWidget {
  const VagasPage({Key? key}) : super(key: key);

  @override
  _VagasPageState createState() => _VagasPageState();
}

class _VagasPageState extends State<VagasPage> {
  List<Vaga> _vagas = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          ListView.builder(
            itemCount: _vagas.length,
            itemBuilder: (context, index) {
              return VagaWidget(vaga: _vagas[index]);
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AddButton(),
          )
        ],
      ),
    );
  }
}
