import 'package:hackaton/cadastro_prop/cadastro_prop.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as pat;
import 'dart:async';

class AppCafeDao {
  static const String databaseName = 'appCafe.db';
  late Future<Database> database;

  //Método para conexão com o banco de dados
  Future connect() async {
    var databasesPath = await getDatabasesPath();
    String path = pat.join(databasesPath, databaseName);
    database = openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) {
        return db
            .execute("CREATE TABLE IF NOT EXISTS ${CadastroProp.tableName} ( "
                "${CadastroProp.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, "
                "${CadastroProp.columnPropriedade} TEXT, "
                "${CadastroProp.columnPlantio} INTEGER,"
                "${CadastroProp.columnHectar} DOUBLE)");
      },
    );
  }

  Future<List<CadastroProp>> list() async {
    //carrega o banco de dados
    final Database db = await database;
    //armazena todos os registro em uma lista Map
    final List<Map<String, dynamic>> maps =
        await db.query(CadastroProp.tableName);

    //transforma o Map JSON em um objeto CadastroProp
    return List.generate(maps.length, (i) {
      return CadastroProp(
        //idPropriedade: maps[i][CadastroProp.columnId],
        nomePropriedade: maps[i][CadastroProp.columnPropriedade],
        tamanhoHectar: maps[i][CadastroProp.columnHectar],
        dataPlantio: maps[i][CadastroProp.columnPlantio],
      );
    });
  }

  Future<void> insert(CadastroProp cadastroProp) async {
    final Database db = await database;
    await db.insert(
      CadastroProp.tableName,
      cadastroProp.toMap(),
    );
  }

  Future<void> delete(int id) async {
    final Database db = await database;
    await db.delete(
      CadastroProp.tableName,
      where: '${CadastroProp.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<void> edit(CadastroProp cadastroProp) async {
    final Database db = await database;
    await db.update(
      CadastroProp.tableName,
      cadastroProp.toMap(),
      where: '${CadastroProp.columnId} = ?',
      whereArgs: [cadastroProp.idPropriedade],
    );
  }
}
