class Usuario {
  int id;
  String nome;
  String email;
  String dataNasc;
  String nomeUsuario;
  String senha;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.dataNasc,
    required this.nomeUsuario,
    required this.senha,
  });

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