const String tabelaUsuario = "tabelaUsuario";
const String idColumn = "idColumn";
const String nomeCompletoColumn = "nomeCompletoColumn";
const String dataNascimentoColumn = "dataNascimentoColumn";
const String usuarioColumn = "usuarioColumn";
const String emailColumn = "emailColumn";
const String senhaColumn = "senhaColumn";

class Usuario {
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
