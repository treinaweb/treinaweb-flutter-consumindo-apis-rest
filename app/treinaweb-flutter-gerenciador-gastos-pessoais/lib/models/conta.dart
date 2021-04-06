import 'package:gerenciador_gastos_pessoais/models/transacao.dart';

class Conta {
  int id;
  String titulo;
  double saldo;
  List<Transacao> transacoes;

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
    var list = json["transacoes"] as List;
    List<Transacao> transacaoList = list.map((e) => 
      Transacao.fromJson(e)).toList();
    id = json["id"];
    titulo = json["titulo"];
    saldo = json["saldo"];
    transacoes = transacaoList;
  }

  Conta.fromMap(Map map) {
    id = map["id"];
    titulo = map["titulo"];
    saldo = map["saldo"];
  }
}