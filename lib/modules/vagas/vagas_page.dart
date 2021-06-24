import 'package:estacionamento/model/vaga.dart';
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
    return Center(
      child: Text('Vagas'),
    );
  }
}
