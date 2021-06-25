import 'package:estacionamento/model/entrada.dart';
import 'package:estacionamento/model/vaga.dart';

class Store {
  static List<Vaga> _vagas = [];

  static List<Entrada> _entradas = [];

  static List<Vaga> get vagas => _vagas;

  static String filter = '';

  static List<Vaga> get vagasFiltradas {
    if (filter == '') {
      return _vagas;
    }
    var filtroVaga = _vagas
        .where((element) =>
            element.id.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    var filtroVeicle = _vagas
        .where((element) =>
            element.veicle.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    var newList = [...filtroVaga, ...filtroVeicle].toSet().toList();

    return newList;
  }

  static List<Entrada> get entradasFiltradas {
    if (filter == '') {
      return _entradas;
    }

    var filtroVaga = _entradas
        .where((element) =>
            element.vaga.id.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    var filtroVeicle = _entradas
        .where((element) =>
            element.veicle.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    var filtroEntryTime = _entradas
        .where((element) =>
            element.entryTime.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    var newList =
        [...filtroVaga, ...filtroVeicle, ...filtroEntryTime].toSet().toList();

    return newList;
  }

  static addVaga(Vaga vaga) {
    if (containsVaga(vaga.id)) {
      return;
    }
    _vagas.add(vaga);
  }

  static removeVaga(Vaga vaga) {
    _vagas.remove(vaga);
  }

  static getVagaIndex(Vaga vaga) {
    int itemIndex = _vagas.indexOf(vaga);
    return itemIndex;
  }

  static bool containsVaga(String id) {
    if (_vagas.indexWhere((element) => element.id == id) != -1) {
      return true;
    }
    return false;
  }

  static limparVagas() {
    _vagas = [];
  }

  static getEntradaIndex(Entrada entrada) {
    int itemIndex = _entradas.indexOf(entrada);
    return itemIndex;
  }

  static setVagaVeicle(int itemIndex, String veicle) {
    _vagas.elementAt(itemIndex).veicle = veicle;
    _vagas.elementAt(itemIndex).isVacant = false;
  }

  static registrarSaida(Entrada entrada, String exitTime) {
    int itemIndex = getEntradaIndex(entrada);
    _entradas.elementAt(itemIndex).exitTime = exitTime;
    _entradas.elementAt(itemIndex).vaga.veicle = 'Vazio';
    _entradas.elementAt(itemIndex).vaga.isVacant = true;
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
    entrada.vaga.veicle = 'Vazio';
    entrada.vaga.isVacant = true;
    _entradas.remove(entrada);
  }

  static limparEntradas() {
    _entradas = [];
  }
}
