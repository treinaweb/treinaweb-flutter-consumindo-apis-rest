"""empty message

Revision ID: c7cbc71fd5af
Revises: 070792ea55b4
Create Date: 2020-12-08 09:55:57.148743

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'c7cbc71fd5af'
down_revision = '070792ea55b4'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('conta', sa.Column('usuario_id', sa.Integer(), nullable=True))
    op.create_foreign_key(None, 'conta', 'usuario', ['usuario_id'], ['id'])
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'conta', type_='foreignkey')
    op.drop_column('conta', 'usuario_id')
    # ### end Alembic commands ###
