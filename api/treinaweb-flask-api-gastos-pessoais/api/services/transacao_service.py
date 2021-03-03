from ..models import transacao_model, conta_model
from api import db
from .conta_service import alterar_saldo_conta

def cadastrar_transacao(transacao):
    transacao_bd = transacao_model.Transacao(titulo=transacao.titulo, descricao=transacao.descricao,
                                             valor=transacao.valor, tipo=transacao.tipo, data=transacao.data,
                                             conta_id=transacao.conta)
    db.session.add(transacao_bd)
    db.session.commit()
    alterar_saldo_conta(transacao.conta, transacao, 1)
    return transacao_bd

def listar_transacoes(usuario):
    transacoes = transacao_model.Transacao.query.join(conta_model.Conta).all()
    # transacoes = transacao_model.Transacao.query.all()
    return transacoes

def listar_transacao_id(id):
    transacao = transacao_model.Transacao.query.filter_by(id=id).first()
    return transacao

def editar_transacao(transacao_bd, transacao_nova):
    valor_antigo = transacao_bd.valor
    transacao_bd.titulo = transacao_nova.titulo
    transacao_bd.descricao = transacao_nova.descricao
    transacao_bd.valor = transacao_nova.valor
    transacao_bd.tipo = transacao_nova.tipo
    transacao_bd.data = transacao_nova.data
    transacao_bd.conta = transacao_bd.conta
    db.session.commit()
    alterar_saldo_conta(transacao_nova.conta, transacao_nova, 2, valor_antigo)
    return transacao_bd

def remover_transacao(transacao):
    db.session.delete(transacao)
    db.session.commit()
    alterar_saldo_conta(transacao.conta_id, transacao, 3)