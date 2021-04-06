import 'dart:convert';

import 'package:gerenciador_gastos_pessoais/models/transacao.dart';
import 'package:gerenciador_gastos_pessoais/utils/rest_util.dart';
import 'package:http/http.dart';

class TransacaoRestService {
  Future<Transacao> addTransacao(Transacao transacao) async {
    final response = await RestUtil.addData('transacoes', transacao.toJson());
  }

  Future<List<Transacao>> getTransacoes() async {
    final response = await RestUtil.getData('transacoes');
    if (response.statusCode == 200) {
      List<dynamic> conteudo = jsonDecode(response.body);
      List<Transacao> transacoes = conteudo.map((dynamic transacao) =>
          Transacao.fromJson(transacao)).toList();
      return transacoes;
    } else {
      throw Exception("Erro ao listar transações");
    }
  }

  Future<Transacao> getTransacaoId(String id) async {
    final response = await RestUtil.getDataId('transacoes', id);
    if (response.statusCode == 200) {
      return Transacao.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao buscar a transação");
    }
  }
}