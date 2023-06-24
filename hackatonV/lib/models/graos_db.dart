import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as pat;
import 'dart:async';

import 'banco.dart';

class Graos {
  static final Graos _instance = Graos.internal();
  factory Graos() => _instance;
  Graos.internal();
  static const String databaseName = 'graos.db';
  late Future<Database> database;

  //Método para conexão com o banco de dados
  Future connect() async {
    var databasesPath = await getDatabasesPath();
    String path = pat.join(databasesPath, databaseName);
    database = openDatabase(
      path,
      version: 3,
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

  void _atualizarTabelas(Database db) {
    _criarTabelas(db);
  }

  void _criarTabelas(Database db) {
    _createUsuariosTable(db);
    _createFazendasTable(db);
  }

  void _createUsuariosTable(Database db) {
    db.execute("CREATE TABLE IF NOT EXISTS ${Usuario.tabelaUsuario} ( "
        "${Usuario.idColumn} INTEGER PRIMARY KEY,"
        "${Usuario.nomeCompletoColumn} TEXT,"
        "${Usuario.dataNascimentoColumn} TEXT,"
        "${Usuario.usuarioColumn} TEXT,"
        "${Usuario.emailColumn} TEXT,"
        "${Usuario.senhaColumn} TEXT)");
  }

  void _createFazendasTable(Database db) {
    db.execute("CREATE TABLE IF NOT EXISTS ${Fazenda.tabelaFazenda} ( "
        "${Fazenda.idColumn} INTEGER PRIMARY KEY,"
        "${Fazenda.nomeFarmColumn} TEXT,"
        "${Fazenda.hectarColumn} REAL,"
        "${Fazenda.tipoColumn} TEXT,"
        "${Fazenda.cidadeColumn} TEXT,"
        "${Fazenda.estadoColumn} TEXT,"
        "${Fazenda.userIdColumn} REFERENCES usuarios(id))");
  }

  Future<int> insertUsuario(Usuario usuario) async {
    final db = await database;
    return await db.insert(Usuario.tabelaUsuario, usuario.toMap());
  }

  Future<int> updateUsuario(Usuario usuario) async {
    final db = await database;
    return await db.update(
      Usuario.tabelaUsuario,
      usuario.toMap(),
      where: '${Usuario.idColumn} = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<Usuario?> getUsuario(String usuario, String senha) async {
    final db = await database;
    List<Map> maps = await db.query(Usuario.tabelaUsuario,
        columns: [
          Usuario.idColumn,
          Usuario.nomeCompletoColumn,
          Usuario.emailColumn,
          Usuario.dataNascimentoColumn,
          Usuario.usuarioColumn,
          Usuario.senhaColumn
        ],
        where: '${Usuario.emailColumn} = ?',
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

  Future<int> insertFazenda(Fazenda fazenda) async {
    final db = await database;
    int id = await db.insert(Fazenda.tabelaFazenda, fazenda.toMap());
    return id;
  }

  Future<int> updateFazenda(Fazenda fazenda) async {
    final db = await database;
    return await db.update(
      Fazenda.tabelaFazenda,
      fazenda.toMap(),
      where: '${Fazenda.idColumn} = ?',
      whereArgs: [fazenda.fazendaID],
    );
  }

  Future<List<Fazenda>> getFazendasPorUsuario(int idUsuario) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'fazendas',
      where: 'idUsuario = ?',
      whereArgs: [idUsuario],
    );
    return List.generate(maps.length, (index) {
      return Fazenda(
        fazendaID: maps[index]['fazendaID'],
        nomeFazenda: maps[index]['nomeFazenda'],
        hectar: maps[index]['hectare'],
        tipoPlantio: maps[index]['tipoPlantio'],
        cidade: maps[index]['cidade'],
        estado: maps[index]['estado'],
        idUsuario: maps[index]['idUsuario'],
      );
    });
  }
}

//   Future<List<CadastroProp>> list() async {
//     //carrega o banco de dados
//     final Database db = await database;
//     //armazena todos os registro em uma lista Map
//     final List<Map<String, dynamic>> maps =
//         await db.query(CadastroProp.tableName);

//     //transforma o Map JSON em um objeto CadastroProp
//     return List.generate(maps.length, (i) {
//       return CadastroProp(
//         //idPropriedade: maps[i][CadastroProp.columnId],
//         nomePropriedade: maps[i][CadastroProp.columnPropriedade],
//         tamanhoHectar: maps[i][CadastroProp.columnHectar],
//         dataPlantio: maps[i][CadastroProp.columnPlantio],
//       );
//     });
//   }

//   Future<void> insert(CadastroProp cadastroProp) async {
//     final Database db = await database;
//     await db.insert(
//       CadastroProp.tableName,
//       cadastroProp.toMap(),
//     );
//   }

//   Future<void> delete(int id) async {
//     final Database db = await database;
//     await db.delete(
//       CadastroProp.tableName,
//       where: '${CadastroProp.columnId} = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<void> edit(CadastroProp cadastroProp) async {
//     final Database db = await database;
//     await db.update(
//       CadastroProp.tableName,
//       cadastroProp.toMap(),
//       where: '${CadastroProp.columnId} = ?',
//       whereArgs: [cadastroProp.idPropriedade],
//     );
//   }
// }
