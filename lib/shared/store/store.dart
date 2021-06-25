import 'package:estacionamento/model/entrada.dart';
import 'package:estacionamento/model/vaga.dart';

class Store {
  static List<Vaga> _vagas = [];

  static List<Entrada> _entradas = [];

  static List<Vaga> get vagas => _vagas;

  static addVaga(Vaga vaga) {
    if (containsVaga(vaga.id)) {
      return;
    }
    _vagas.add(vaga);
  }

  static removeVaga(Vaga vaga) {
    _vagas.remove(vaga);
  }

  static bool containsVaga(String id) {
    if (_vagas.indexWhere((element) => element.id == id) != -1) {
      return true;
    }
    return false;
  }

  static setVagaVeicle(int itemIndex, String veicle) {
    _vagas.elementAt(itemIndex).veicle = veicle;
    _vagas.elementAt(itemIndex).isVacant = false;
  }

  static List<Entrada> get entradas => _entradas;

  static addEntrada(Entrada entrada) {
    _entradas.add(entrada);

    int itemIndex =
        _vagas.indexWhere((element) => element.id == entrada.vaga.id);
    if (itemIndex != -1) {
      setVagaVeicle(itemIndex, entrada.veicle);
      return;
    }

    _vagas.add(entrada.vaga);
  }

  static removeEntrada(Entrada entrada) {
    _entradas.remove(entrada);
    _entradas.forEach((element) {
      print(element.vaga.id);
    });
  }
}
