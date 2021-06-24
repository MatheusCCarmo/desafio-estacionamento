import 'package:estacionamento/model/entrada.dart';
import 'package:estacionamento/model/vaga.dart';

class Store {
  static List<Vaga> _vagas = [];

  static List<Entrada> _entradas = [];

  static List<Vaga> get vagas => _vagas;

  static addVaga(Vaga vaga) {
    _vagas.add(vaga);
  }

  static List<Entrada> get entradas => _entradas;

  static addEntrada(Entrada entrada) {
    _entradas.add(entrada);
  }

  static removeEntrada(Entrada entrada) {
    _entradas.remove(entrada);
  }
}
