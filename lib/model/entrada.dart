import 'package:estacionamento/model/vaga.dart';

class Entrada {
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
