import 'package:estacionamento/model/entrada.dart';
import 'package:estacionamento/model/vaga.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class Store {
  static List<Vaga> _vagas = [];

  static List<Entrada> _entradas = [];

  static List<Entrada> _historico = [];

  static List<Vaga> get vagas => _vagas;

  static List<Entrada> get entradas => _entradas;

  static List<Entrada> get historico => _historico;

  static String filter = '';

  static Future<void> _saveVagas() async {
    await GetStorage().write('vagas', json.encode(_vagas));
  }

  static loadVagas() {
    if (GetStorage().read('vagas') == null) {
      _vagas = [];
      return;
    }
    String vagasData = GetStorage().read('vagas');

    List<dynamic> listaDeJson = json.decode(vagasData);

    List<Vaga> listaVagas = listaDeJson.map((e) => Vaga.fromJson(e)).toList();

    _vagas = listaVagas;
  }

  static Future<void> _saveEntradas() async {
    GetStorage().write('entradas', json.encode(_entradas));
  }

  static loadEntradas() {
    if (GetStorage().read('entradas') == null) {
      _entradas = [];
      return;
    }
    String entradasData = GetStorage().read('entradas');

    List<dynamic> listaDeJson = json.decode(entradasData);

    List<Entrada> listaEntradas =
        listaDeJson.map((e) => Entrada.fromJson(e)).toList();

    _entradas = listaEntradas;
  }

  static Future<void> _saveHistorico() async {
    GetStorage().write('historico', json.encode(_historico));
  }

  static loadHistorico() async {
    if (GetStorage().read('historico') == null) {
      _historico = [];
      return;
    }
    String historicoData = GetStorage().read('historico');

    List<dynamic> listaDeJson = json.decode(historicoData);

    List<Entrada> listaHistorico =
        listaDeJson.map((e) => Entrada.fromJson(e)).toList();

    _historico = listaHistorico;
  }

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

    var newList = [...filtroVeicle, ...filtroVaga].toSet().toList();

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
        [...filtroEntryTime, ...filtroVeicle, ...filtroVaga].toSet().toList();

    return newList;
  }

  static List<Entrada> get historicoFiltrado {
    if (filter == '') {
      return _historico;
    }

    var filtroVaga = _historico
        .where((element) =>
            element.vaga.id.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    var filtroVeicle = _historico
        .where((element) =>
            element.veicle.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    var filtroEntryTime = _historico
        .where((element) =>
            element.entryTime.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    var filtroExitTime = _historico
        .where((element) =>
            element.exitTime.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    var newList = [
      ...filtroEntryTime,
      ...filtroExitTime,
      ...filtroVeicle,
      ...filtroVaga,
    ].toSet().toList();

    return newList;
  }

  static sortVagas() {
    _vagas.sort((a, b) => a.id.compareTo(b.id));
    _saveVagas();
  }

  static sortEntradas() {
    _entradas.sort((a, b) => b.vaga.id.compareTo(a.vaga.id));
    _saveEntradas();
  }

  static sortHistorico() {
    _historico.sort((a, b) => b.vaga.id.compareTo(a.vaga.id));
    _saveHistorico();
  }

  static Vaga getVagaById(String id) {
    return _vagas.firstWhere(
      (element) => element.id == id,
      orElse: () => Vaga(id: id),
    );
  }

  static addVaga(Vaga vaga) {
    if (containsVaga(vaga.id)) {
      return;
    }
    _vagas.add(vaga);
    _saveVagas();
  }

  static removeVaga(Vaga vaga) {
    _vagas.remove(vaga);
    _saveVagas();
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

  static limparVagasVazias() {
    _vagas = _vagas.where((element) => !element.isVacant).toList();
    _saveVagas();
  }

  static getEntradaIndex(Entrada entrada) {
    int itemIndex = _entradas.indexOf(entrada);
    return itemIndex;
  }

  static getHistoricoIndex(Entrada entrada) {
    int itemIndex = _entradas.indexOf(entrada);
    return itemIndex;
  }

  static setVagaVeicle(int itemIndex, String veicle) {
    _vagas.elementAt(itemIndex).veicle = veicle;
    _vagas.elementAt(itemIndex).isVacant = false;
    _saveVagas();
  }

  static registrarSaida(Entrada entrada, String exitTime) {
    int entradaIndex = getEntradaIndex(entrada);
    _entradas.elementAt(entradaIndex).exitTime = exitTime;
    _entradas.elementAt(entradaIndex).vaga.veicle = 'VAZIO';
    _entradas.elementAt(entradaIndex).vaga.isVacant = true;

    int historicoIndex = getHistoricoIndex(entrada);
    _historico.elementAt(historicoIndex).exitTime = exitTime;

    _saveVagas();
    _saveHistorico();
    _saveEntradas();
  }

  static addEntrada(Entrada entrada) {
    _entradas.add(entrada);
    _historico.add(entrada);

    _saveHistorico();
    _saveEntradas();

    int itemIndex =
        _vagas.indexWhere((element) => element.id == entrada.vaga.id);
    if (itemIndex != -1) {
      setVagaVeicle(itemIndex, entrada.veicle);
      return;
    }

    _vagas.add(entrada.vaga);
    _saveVagas();
  }

  static removeEntrada(Entrada entrada) {
    entrada.vaga.veicle = 'VAZIO';
    entrada.vaga.isVacant = true;
    _entradas.remove(entrada);
    _saveVagas();
    _saveEntradas();
  }

  static limparEntradas() {
    _entradas.forEach((element) {
      element.vaga.veicle = 'VAZIO';
      element.vaga.isVacant = true;
    });
    _entradas = [];
    _saveVagas();
    _saveEntradas();
  }

  static limparHistorico() {
    _historico = [];
    _saveHistorico();
  }
}
