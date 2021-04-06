import 'package:flutter/material.dart';
import 'package:gerenciador_gastos_pessoais/models/conta.dart';
import 'package:gerenciador_gastos_pessoais/models/transacao.dart';
import 'package:gerenciador_gastos_pessoais/screens/components/card_conta.dart';
import 'package:gerenciador_gastos_pessoais/screens/components/card_transacao.dart';
import 'package:gerenciador_gastos_pessoais/screens/transacao/transacao_screen.dart';
import 'package:gerenciador_gastos_pessoais/services/conta_rest_service.dart';
import 'package:gerenciador_gastos_pessoais/services/conta_service.dart';
import 'package:gerenciador_gastos_pessoais/services/transacao_service.dart';

class Body extends StatefulWidget {
  final int id;

  Body({this.id});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TransacaoService ts = TransacaoService();
  ContaService cs = ContaService();
  ContaRestService crs = ContaRestService();
  Future<List> _loadTransacoes;
  Future<Conta> _loadConta;
  List<Transacao> _transacoes;
  Conta _conta;

  @override
  void initState() {
    // TODO: implement initState
    _loadTransacoes = _getTransacoes(widget.id);
    _loadConta = _getConta(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadConta,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            _conta = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 67, bottom: 16),
                  child: Container(
                      height: 175,
                      width: double.infinity,
                      child: cardConta(context, _conta)),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Todas as transações",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _conta.transacoes.length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return cardTransacao(
                            context, index, _conta.transacoes[index]);
                      }),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<List> _getTransacoes(int id) async {
    return await ts.getTransacoesConta(id);
  }

  Future<Conta> _getConta(int id) async {
    return await crs.getContaId(id.toString());
  }
}
