import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'dart:async';

import '../models/tabela_usuario.dart';

//classe para o gerenciamento de Contatos
class UsuarioDao {
  static const String databaseName = 'hack.db';
  late Future<Database> database;

  //Método para conexão com o banco de dados
  Future connect() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, databaseName);
    database = openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) {
        return db.execute("CREATE TABLE IF NOT EXISTS ${Usuario.tableName} ( "
            "${Usuario.columnId} TEXT PRIMARY KEY AUTOINCREMENT, "
            "${Usuario.columnName} TEXT, "
            "${Usuario.columnEmail} TEXT, "
            "${Usuario.columnNasc} TEXT, "
            "${Usuario.columnNasc} TEXT) ");
      },
    );
  }

  //Método para retornar todos os registros do banco de dados
  Future<List<Usuario>> list() async {
    //carrega o banco de dados
    final Database db = await database;
    //aramzena todos os registro em uma lista Map
    final List<Map<String, dynamic>> maps = await db.query(Usuario.tableName);

    //transfprma o Map JSON em um objeto Contact
    return List.generate(maps.length, (i) {
      return Usuario(
        id: maps[i][Usuario.columnId],
        name: maps[i][Usuario.columnName],
        email: maps[i][Usuario.columnEmail],
        nasc: maps[i][Usuario.columnNasc],
        senha: maps[i][Usuario.columnSenha],
      );
    });
  }

// Método para inserir um contato na banco de dados
  Future<void> insert(Usuario usuario) async {
    final Database db = await database;
    await db.insert(
      Usuario.tableName,
      usuario.toMap(),
    );
  }

  //Método para atualizar um registro
  Future<void> update(Usuario usuario) async {
    final db = await database;
    await db.update(
      Usuario.tableName,
      usuario.toMap(),
      where: "${Usuario.columnId} = ?",
      whereArgs: [usuario.name],
    );
  }

  //Método Para Deletar um registro
  Future<void> delete(String name) async {
    final db = await database;
    await db.delete(
      Usuario.tableName,
      where: "${Usuario.columnName} = ?",
      whereArgs: [name],
    );
  }
}
