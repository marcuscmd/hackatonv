class Usuario {
  late int id;
  late String nome;
  late String email;
  late String dataNasc;
  late String nomeUsuario;
  late String senha;

  Usuario(this.nome, this.email, this.dataNasc, this.nomeUsuario, this.senha);

  Usuario.fromMap(Map map) {
    id = map[id];
    nome = map[nome];
    dataNasc = map[dataNasc];
    nomeUsuario = map[nomeUsuario];
    email = map[email];
    senha = map[senha];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'dataNasc': dataNasc,
      'nomeUsuario': nomeUsuario,
      'senha': senha,
    };
  }
}

class Fazenda {
  int fazendaID;
  String nomeFazenda;
  double hectar;
  String tipoPlantio;
  String cidade;
  String estado;
  int idUsuario; // Chave estrangeira

  Fazenda({
    required this.fazendaID,
    required this.nomeFazenda,
    required this.hectar,
    required this.tipoPlantio,
    required this.cidade,
    required this.estado,
    required this.idUsuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'fazendaID': fazendaID,
      'nomeFazenda': nomeFazenda,
      'hectar': hectar,
      'tipoPlantio': tipoPlantio,
      'cidade': cidade,
      'estado': estado,
      'idUsuario': idUsuario,
    };
  }
}
