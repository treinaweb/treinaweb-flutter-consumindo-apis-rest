import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_gastos_pessoais/models/conta.dart';
import 'package:gerenciador_gastos_pessoais/models/transacao.dart';
import 'package:gerenciador_gastos_pessoais/screens/home/home_screen.dart';
import 'package:gerenciador_gastos_pessoais/services/conta_rest_service.dart';
import 'package:gerenciador_gastos_pessoais/services/conta_service.dart';
import 'package:gerenciador_gastos_pessoais/services/transacao_rest_service.dart';
import 'package:gerenciador_gastos_pessoais/services/transacao_service.dart';

class EditarTransacaoScreen extends StatefulWidget {
  final String idTransacao;

  EditarTransacaoScreen({this.idTransacao});
  @override
  _EditarTransacaoScreenState createState() => _EditarTransacaoScreenState();
}

class _EditarTransacaoScreenState extends State<EditarTransacaoScreen> {
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  final _dataController = TextEditingController();
  Conta _contaSelecionada;
  Transacao _transacao;
  ContaService cs = ContaService();
  ContaRestService crs = ContaRestService();
  Future<List> _loadContas;
  Future<Transacao> _loadTransacao;
  List<Conta> _contas;
  DateTime selectedDate = DateTime.now();
  TransacaoService ts = TransacaoService();
  TransacaoRestService trs = TransacaoRestService();

  @override
  void initState() {
    // TODO: implement initState
    _loadTransacao = _getTransacao(widget.idTransacao);
    _loadContas = _getContas();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar transação"),
      ),
      body: FutureBuilder(
        future: _loadTransacao,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.hasData) {
            _transacao = snapshot.data;
            _tituloController.text = _transacao.titulo;
            _descricaoController.text = _transacao.descricao;
            _valorController.text = _transacao.valor.toString();
            _dataController.text = _transacao.data;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _tituloController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Título"),
                      ),
                      TextFormField(
                        controller: _descricaoController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Descrição"),
                      ),
                      TextFormField(
                        controller: _valorController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "Valor"),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _dataController,
                            decoration: InputDecoration(
                              labelText: formatDate(selectedDate,
                                  [dd, '/', mm, '/', yyyy]),
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: _loadContas,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            _contas = snapshot.data;
                            var indice = _contas.indexWhere((conta) => conta.id == _transacao.conta);
                            _contaSelecionada = _contas[indice];
                            return DropdownButtonFormField(
                              value: _contaSelecionada,
                              onChanged: (Conta conta) {
                                setState(() {
                                  _contaSelecionada = conta;
                                });
                              },
                              items: _contas.map((conta) {
                                return DropdownMenuItem<Conta>(
                                  value: conta, child: Text(conta.titulo),
                                );
                              }).toList(),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Transacao newTransacao = Transacao(
                                  titulo: _tituloController.text,
                                  descricao: _descricaoController.text,
                                  tipo: _transacao.tipo.toString(),
                                  valor: double.parse(_valorController.text),
                                  data: formatDate(selectedDate,
                                      [yyyy, '-', mm, '-', dd]).toString(),
                                  conta: _contaSelecionada.id
                              );
                              trs.editTransacao(newTransacao, _transacao.id.toString());
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => HomeScreen()
                                  )
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent
                            ),
                            child: Text("Editar",
                              style: TextStyle(color: Colors.white, fontSize: 16),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2018, 01),
        lastDate: DateTime(2030, 01)
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<List> _getContas() async {
    return await crs.getContas();
  }

  Future<Transacao> _getTransacao(String id) async {
    return await trs.getTransacaoId(id);
  }
}
