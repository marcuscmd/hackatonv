class Propriedade {
  static const String tabelaPropriedade = "tabelaPropriedade";
  static const String idColumn = "idColumn";
  static const String nomePropriedadeColumn = "nomePropriedadeColumn";
  static const String hectarColumn = "hectarColumn";
  static const String dataColumn = "dataColumn";
  static const String tipoColumn = "tipoColumn";
  static const String idusuarioColumn = "idusuarioColumn";

  late final int id;
  late final String nomePropriedade;
  late final double hectar;
  late final String data;
  late final String tipo;
  late final int idUsuario;

  Propriedade(
      {required this.id,
      required this.nomePropriedade,
      required this.hectar,
      required this.data,
      required this.tipo,
      required this.idUsuario});

  Propriedade.fromMap(Map map) {
    id = map[idColumn];
    nomePropriedade = map[nomePropriedadeColumn];
    data = map[dataColumn];
    hectar = map[hectarColumn];
    tipo = map[tipoColumn];
    idUsuario = map[idusuarioColumn];
  }

  Map<String, dynamic> toMap() {
    return {
      'nomePropriedadeColumn': nomePropriedade,
      'hectarColumn': hectar,
      'dataColumn': data,
      'tipoColumn': tipo,
      'idusuarioColumn': idUsuario
    };
  }
}
