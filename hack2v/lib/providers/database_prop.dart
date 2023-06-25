class Propriedade {

  static const String tabelaPropriedade = "tabelaPropriedade";
  static const String idColumn = "idColumn";
  static const String nomePropriedadeColumn = "nomePropriedadeColumn";
  static const String hectarColumn = "hectarColumn";
  static const String dataColumn = "dataColumn";
  static const String idusuarioColumn = "idusuarioColumn";

  final int id;
  final String nomePropriedade;
  final double hectar;
  final String data;
  final String idUsuario;

  Propriedade(
      {required this.id,
      required this.nomePropriedade,
      required this.hectar,
      required this.data,
      required this.idUsuario});

  Map<String, dynamic> toMap() {
    return {
      'nomePropriedadeColumn': nomePropriedade,
      'hectarColumn': hectar,
      'dataColumn': data,
      'idusuarioColumn': idUsuario
    };
  }
}
