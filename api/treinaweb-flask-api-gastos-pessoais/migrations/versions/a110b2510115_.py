"""empty message

Revision ID: a110b2510115
Revises: a888e75103b5
Create Date: 2021-02-17 16:57:49.665802

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'a110b2510115'
down_revision = 'a888e75103b5'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint('conta_ibfk_1', 'conta', type_='foreignkey')
    op.drop_column('conta', 'usuario_id')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('conta', sa.Column('usuario_id', mysql.INTEGER(), autoincrement=False, nullable=True))
    op.create_foreign_key('conta_ibfk_1', 'conta', 'usuario', ['usuario_id'], ['id'])
    # ### end Alembic commands ###
