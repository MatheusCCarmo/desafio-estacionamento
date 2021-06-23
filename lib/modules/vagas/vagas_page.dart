import 'package:estacionamento/modules/vagas/vaga_widget.dart';
import 'package:flutter/material.dart';

class VagasPage extends StatefulWidget {
  const VagasPage({Key? key}) : super(key: key);

  @override
  _VagasPageState createState() => _VagasPageState();
}

class _VagasPageState extends State<VagasPage> {
  List<Widget> vagas = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          VagaWidget(),
          VagaWidget(),
          VagaWidget(),
          VagaWidget(),
        ],
      ),
    );
  }
}
