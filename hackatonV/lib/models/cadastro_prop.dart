class CadastroProp {
  static const String tableName = 'Cadastro_Propriedade';
  static const String columnPropriedade = 'nomePropriedade';
  static const String columnId = "idPropriedade";
  static const String columnHectar = 'tamanhoHectar';
  static const String columnPlantio = 'dataPlantio';

  final String nomePropriedade;
  final double tamanhoHectar;
  final int dataPlantio;
  //final int idPropriedade;
  int? idPropriedade;

  CadastroProp({
    required this.nomePropriedade,
    required this.tamanhoHectar,
    required this.dataPlantio,
    //required this.idPropriedade
  });

  Map<String, dynamic> toMap() {
    return {
      'nomePropriedade': nomePropriedade,
      'tamanhoHectar': tamanhoHectar,
      'dataPlantio': dataPlantio,
    };
  }

  int get getIdPropriedade => idPropriedade!;
}
