class Store < ApplicationRecord
  # Define a relação entre as tabelas
  has_many :transactions, dependent: :destroy

  # Validações dos campos obrigatórios
  validates :name, :owner, presence: true
end
