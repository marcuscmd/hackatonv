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
const String loginColumn = "loginColumn";

class Usuario {
  late int id;
  late String nome;
  late String dataNasc;
  late String usuario;
  late String email;
  late String senha;
  late bool login = false;

  Usuario(this.nome, this.dataNasc, this.usuario, this.email, this.senha);

  Usuario.fromMap(Map map) {
    id = map[idColumn];
    nome = map[nomeColumn];
    dataNasc = map[dataNascColumn];
    usuario = map[usuarioColumn];
    email = map[emailColumn];
    senha = map[senhaColumn];
    login = map[loginColumn] == true ? true : false;
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
      version: 3, // Incrementa a versão do banco de dados
      onCreate: (db, version) {
        return _criarTabelas(db);
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < newVersion) {
          return _atualizarTabelas(db);
        }
      },
    );
  }

  void _createUserTable(Database db) {
    db.execute("CREATE TABLE IF NOT EXISTS $tabelaUsuario ( "
        "$idColumn INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$nomeColumn TEXT,"
        "$emailColumn TEXT,"
        "$dataNascColumn TEXT,"
        "$usuarioColumn TEXT,"
        "$senhaColumn TEXT,"
        "$loginColumn BOOLEAN)");
  }

  void _createPropriedadeTable(Database db) {
    db.execute("CREATE TABLE IF NOT EXISTS ${Propriedade.tabelaPropriedade} ( "
        "${Propriedade.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${Propriedade.nomePropriedadeColumn} TEXT,"
        "${Propriedade.hectarColumn} real,"
        "${Propriedade.dataColumn} TEXT,"
        "${Propriedade.tipoColumn} TEXT,"
        "${Propriedade.idusuarioColumn} INTEGER,"
        "FOREIGN KEY (${Propriedade.idusuarioColumn}) REFERENCES $tabelaUsuario ($idColumn))");
  }

  void _criarTabelas(Database db) {
    _createPropriedadeTable(db);
    _createUserTable(db);
  }

  Future<int> insertUsuario(Usuario usuario) async {
    final db = await database;
    return await db.insert(tabelaUsuario, usuario.toMap());
  }

  Future<int> updateUsuario(Usuario usuario) async {
    final db = await database;
    return await db.update(
      tabelaUsuario,
      usuario.toMap(),
      where: "$idColumn = ?",
      whereArgs: [usuario.id],
    );
  }

  Future<Usuario?> getUsuario(String usuario, String senha) async {
    final db = await database;
    List<Map> maps = await db.query(tabelaUsuario,
        columns: [
          idColumn,
          nomeColumn,
          emailColumn,
          dataNascColumn,
          usuarioColumn,
          senhaColumn,
          loginColumn
        ],
        where: "$emailColumn = ?",
        whereArgs: [usuario]);
    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Usuario>> getAllUsuarios() async {
    final db = await database;
    List listMap = await db.rawQuery("SELECT * FROM tabelaUsuarios");
    List<Usuario> listUsuarios = [];
    for (Map m in listMap) {
      listUsuarios.add(Usuario.fromMap(m));
    }
    return listUsuarios;
  }

  Future<int> insertFazenda(Propriedade propriedade) async {
    final db = await database;
    int id =
        await db.insert(Propriedade.tabelaPropriedade, propriedade.toMap());
    return id;
  }

  Future<int> updateFazenda(Propriedade propriedade) async {
    final db = await database;
    return await db.update(
      Propriedade.tabelaPropriedade,
      propriedade.toMap(),
      where: '${Propriedade.idColumn} = ?',
      whereArgs: [propriedade.id],
    );
  }

  Future<List<Propriedade>> getFazendasPorUsuario(int idUsuario) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      Propriedade.tabelaPropriedade,
      where: '${Propriedade.idusuarioColumn} = ?',
      whereArgs: [idUsuario],
    );
    return List.generate(maps.length, (index) {
      return Propriedade(
        id: maps[index][Propriedade.idColumn],
        nomePropriedade: maps[index][Propriedade.nomePropriedadeColumn],
        hectar: maps[index][Propriedade.hectarColumn],
        data: maps[index][Propriedade.dataColumn],
        tipo: maps[index][Propriedade.tipoColumn],
        idUsuario: maps[index][Propriedade.idusuarioColumn],
      );
    });
  }

  void _atualizarTabelas(Database db) {
    // Adicione aqui a lógica para atualizar as tabelas existentes, se necessário
    _criarTabelas(db);
  }

  Future<int?> getUserId() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tabelaUsuario,
        columns: [idColumn], where: '$loginColumn = ?', whereArgs: [true]);
    if (maps.isNotEmpty) {
      // O usuário está autenticado, então você pode obter o ID
      final userId = maps.first[idColumn];
      return userId;
    } else {
      // O usuário não está autenticado
      return null;
    }
  }

  Future<void> updateUserLoggedInStatus(
      bool isLoggedIn, Usuario usuario) async {
    final newValue = isLoggedIn ? true : false;
    final db = await database;

    await db.update(
      tabelaUsuario,
      {'loginColumn': newValue},
      where: "$idColumn = ?",
      whereArgs: [usuario.id],
    );
  }

  Future<void> deslogar() async {
    final db = await database;
    const newValue = false;

    await db.update(
      tabelaUsuario,
      {'loginColumn': newValue},
      where: 'loginColumn = ?',
      whereArgs: [true],
    );
  }

  Future<Propriedade?> getFazendaInfo(int propid) async {
    final db = await database;
    List<Map> maps = await db.query(Propriedade.tabelaPropriedade,
        columns: [
          Propriedade.idColumn,
          Propriedade.nomePropriedadeColumn,
          Propriedade.hectarColumn,
          Propriedade.dataColumn,
          Propriedade.idusuarioColumn,
          Propriedade.tipoColumn
        ],
        where: "$propid = ?",
        whereArgs: [Propriedade.idColumn]);
    if (maps.isNotEmpty) {
      return Propriedade.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
