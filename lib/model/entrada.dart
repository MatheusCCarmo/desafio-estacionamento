import 'package:estacionamento/model/vaga.dart';
import 'package:estacionamento/shared/store/store.dart';

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
      : vaga = Store.getVagaById(json['vagaId']),
        veicle = json['veicle'],
        entryTime = json['entryTime'],
        exitTime = json['exitTime'];

  Map<String, dynamic> toJson() => {
        'vagaId': vaga.id,
        'veicle': veicle,
        'entryTime': entryTime,
        'exitTime': exitTime,
      };
}
