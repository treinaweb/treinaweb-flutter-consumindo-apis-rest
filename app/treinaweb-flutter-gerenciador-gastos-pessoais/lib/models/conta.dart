class Conta {
  int id;
  String titulo;
  double saldo;

  Conta({this.id, this.titulo, this.saldo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'saldo': saldo
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'saldo': saldo
    };
  }

  Conta.fromJson(Map json) {
    id = json["id"];
    titulo = json["titulo"];
    saldo = json["saldo"];
  }

  Conta.fromMap(Map map) {
    id = map["id"];
    titulo = map["titulo"];
    saldo = map["saldo"];
  }
}