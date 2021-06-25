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

  Entrada.fromJson(Map<String, dynamic> json)
      : vaga = json['vaga'],
        veicle = json['veicle'],
        entryTime = json['entryTime'],
        exitTime = json['exitTime'];

  Map<String, dynamic> toJson() => {
        'vaga': vaga,
        'veicle': veicle,
        'entryTime': entryTime,
        'exitTime': exitTime,
      };
}
