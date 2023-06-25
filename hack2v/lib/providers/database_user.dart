import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import 'database_prop.dart';

const String tabelaUsuario = "tabelaUsuario";
const String idColumn = "idColumn";
const String nomeColumn = "nomeColumn";
const String emailColumn = "emailColumn";
const String dataNascColumn = "dataNascColumn";
const String usuarioColumn = "usuarioColumn";
const String senhaColumn = "senhaColumn";

class Usuario {
  late int id;
  late String nome;
  late String dataNasc;
  late String usuario;
  late String email;
  late String senha;

  Usuario(this.nome, this.dataNasc, this.usuario, this.email, this.senha);

  Usuario.fromMap(Map map) {
    id = map[idColumn];
    nome = map[nomeColumn];
    dataNasc = map[dataNascColumn];
    usuario = map[usuarioColumn];
    email = map[emailColumn];
    senha = map[senhaColumn];
  }

  Map<String, dynamic> toMap() {
    return {
      nomeColumn: nome,
      dataNascColumn: dataNasc,
      usuarioColumn: usuario,
      emailColumn: email,
      senhaColumn: senha
    };
  }
}

class DataBaseProvider {
  static final DataBaseProvider _instance = DataBaseProvider.internal();
  factory DataBaseProvider() => _instance;
  DataBaseProvider.internal();
  late Future<Database> database;
  static const String databaseName = 'hackaton.db';

  Future<void> initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, databaseName);
    database = openDatabase(
      path,
      version: 1, // Incrementa a versão do banco de dados
      onCreate: (db, version) {
        return _criarTabelas(db);
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < newVersion) {
          //return _atualizarTabelas(db);
        }
      },
    );
  }

    void _createUserTable(Database db) {
    db.execute("CREATE TABLE IF NOT EXISTS $tabelaUsuario ( "
        "$idColumn INTEGER PRIMARY KEY,"
        "$nomeColumn TEXT,"
        "$emailColumn TEXT,"
        "$dataNascColumn TEXT,"
        "$usuarioColumn TEXT,"    
        "$senhaColumn TEXT)");
  }

    void _createPropriedadeTable(Database db) {
    db.execute("CREATE TABLE IF NOT EXISTS ${Propriedade.tabelaPropriedade} ( "
        "${Propriedade.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${Propriedade.nomePropriedadeColumn} TEXT,"
        "${Propriedade.hectarColumn} real,"
        "${Propriedade.dataColumn} TEXT,"
        "FOREIGN KEY (${Propriedade.idusuarioColumn}) REFERENCES $tabelaUsuario ($idColumn)");
  }

  void _criarTabelas(Database db) {
    _createPropriedadeTable(db);
    _createUserTable(db);
  }
}
