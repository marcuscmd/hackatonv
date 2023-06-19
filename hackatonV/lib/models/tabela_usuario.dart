class Usuario {
  static const tableName = 'Usuarios';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnEmail = 'email';
  static const columnNasc = 'nasc';
  static const columnSenha = 'senha';

  final String id;
  final String name;
  final String email;
  final String nasc;
  final String senha;
  


  const Usuario({
    required this.id,
    required this.name,
    required this.email,
    required this.nasc,
    required this.senha
  });

  Map<String, dynamic> toMap(){
    return {'id': id, 'name': name, 'email': email, 'dataNasc': nasc, 'senha': senha};
  }
}