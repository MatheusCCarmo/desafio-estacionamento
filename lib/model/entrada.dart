import 'package:estacionamento/model/vaga.dart';
import 'package:flutter/material.dart';

class Entrada {
  String id = UniqueKey().toString();
  Vaga vaga;
  String veicle;
  String entryTime;
  String exitTime;

  Entrada({
    required this.vaga,
    required this.veicle,
    required this.entryTime,
    this.exitTime = '',
  });
}
