class Agenda {
  final int? id;
  final String? nome;
  final String? sobrenome;
  final String telefone;

  Agenda({
    this.id,
    this.nome,
    this.sobrenome,
    required this.telefone
  });

  // Construtor para criar um Agenda a partir de um JSON vindo da API
  factory Agenda.fromJson(Map<String, dynamic> json){
    return Agenda(
      id: json['id'],
      nome: json['nome'],
      sobrenome: json['sobrenome'],
      telefone: json['telefone']
    );
  }

  // Método para converter um Todo para JSON para enviar para a API
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nome": nome,
      "sobrenome": sobrenome,
      "telefone": telefone
    };
  }
}