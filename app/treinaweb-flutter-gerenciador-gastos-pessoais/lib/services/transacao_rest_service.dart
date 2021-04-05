import 'package:gerenciador_gastos_pessoais/models/transacao.dart';
import 'package:gerenciador_gastos_pessoais/utils/rest_util.dart';
import 'package:http/http.dart';

class TransacaoRestService {
  Future<Transacao> addTransacao(Transacao transacao) async {
    final Response response = await RestUtil.addData('transacoes', transacao.toJson());
  }
}