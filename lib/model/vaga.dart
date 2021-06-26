class Vaga {
  String id;
  bool isVacant;
  String veicle;

  Vaga({
    required this.id,
    this.isVacant = true,
    this.veicle = 'VAZIO',
  });

  Vaga.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        isVacant = json['isVacant'],
        veicle = json['veicle'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'isVacant': isVacant,
        'veicle': veicle,
      };
}
