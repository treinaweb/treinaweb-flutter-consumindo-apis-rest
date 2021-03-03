from api import db

class Conta(db.Model):
    __tablename__ = "conta"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    titulo = db.Column(db.String(50), nullable=False)
    saldo = db.Column(db.Float, nullable=False)