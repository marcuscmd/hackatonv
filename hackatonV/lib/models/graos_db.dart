import 'package:hackaton/cadastro_prop/cadastro_prop.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as pat;
import 'dart:async';

import 'banco.dart';

class Graos {
  static const String databaseName = 'graos.db';

  late Future<Database> database;

  //Método para conexão com o banco de dados
  Future connect() async {
    var databasesPath = await openDatabase(
      pat.join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE usuarios(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            email TEXT,
            dataNasc TEXT,
            nomeUsuario TEXT,
            senha TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE fazendas(
            fazendaID INTEGER PRIMARY KEY AUTOINCREMENT,
            nomeFazenda TEXT,
            hectare REAL,
            tipoPlantio TEXT,
            cidade TEXT,
            estado TEXT,
            idUsuario INTEGER,
            FOREIGN KEY(idUsuario) REFERENCES usuarios(id)
          )
        ''');
      },
      version: 1,
    );
  }

  Future<int> insertUsuario(Usuario usuario) async {
    final db = await database;
    return await db.insert('usuarios', usuario.toMap());
  }

  Future<int> updateUsuario(Usuario usuario) async {
    final db = await database;
    return await db.update(
      'usuarios',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<List<Usuario>> getUsuarios() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('usuarios');
    return List.generate(maps.length, (index) {
      return Usuario(
        id: maps[index]['id'],
        nome: maps[index]['nome'],
        email: maps[index]['email'],
        dataNasc: maps[index]['dataNasc'],
        nomeUsuario: maps[index]['nomeUsuario'],
        senha: maps[index]['senha'],
      );
    });
  }

  Future<int> insertFazenda(Fazenda fazenda) async {
    final db = await database;
    return await db.insert('fazendas', fazenda.toMap());
  }

  Future<int> updateFazenda(Fazenda fazenda) async {
    final db = await database;
    return await db.update(
      'fazendas',
      fazenda.toMap(),
      where: 'fazendaID = ?',
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
