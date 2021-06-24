class Vaga {
  String id;
  bool isVacant;
  String veicle;

  Vaga({
    required this.id,
    this.isVacant = true,
    this.veicle = 'Vazio',
  });
}
