class Usuario {
  static const String tabelaUsuario = "tabelaUsuarios";
  static const String idColumn = "idColumn";
  static const String nomeCompletoColumn = "nomeCompletoColumn";
  static const String dataNascimentoColumn = "dataNascimentoColumn";
  static const String usuarioColumn = "usuarioColumn";
  static const String emailColumn = "emailColumn";
  static const String senhaColumn = "senhaColumn";

  late int id;
  late String nome;
  late String email;
  late String dataNasc;
  late String nomeUsuario;
  late String senha;

  Usuario(this.nome, this.email, this.dataNasc, this.nomeUsuario, this.senha);

  Usuario.fromMap(Map map) {
    id = map[idColumn];
    nome = map[nomeCompletoColumn];
    dataNasc = map[dataNascimentoColumn];
    nomeUsuario = map[usuarioColumn];
    email = map[emailColumn];
    senha = map[senhaColumn];
  }

  Map<String, dynamic> toMap() {
    return {
      nomeCompletoColumn: nome,
      dataNascimentoColumn: dataNasc,
      usuarioColumn: nomeUsuario,
      emailColumn: email,
      senhaColumn: senha
    };
  }
}

class Fazenda {
  static const String tabelaFazenda = "tabelaFazenda";
  static const String idColumn = "idColumn";
  static const String nomeFarmColumn = "nomeFarmColumn";
  static const String hectarColumn = "hectarColumn";
  static const String tipoColumn = "tipoColumn";
  static const String cidadeColumn = "cidadeColumn";
  static const String estadoColumn = "estadoColumn";
  static const String userIdColumn = "userIdColumn";

  final int fazendaID;
  final String nomeFazenda;
  final double hectar;
  final String tipoPlantio;
  final String cidade;
  final String estado;
  final int idUsuario; // Chave estrangeira

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
