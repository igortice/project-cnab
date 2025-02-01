class Transaction < ApplicationRecord
  # Define a relação entre as tabelas
  belongs_to :store

  # Define os tipos de transações possíveis
  enum transaction_type: {
    debito:                 1,
    boleto:                 2,
    financiamento:          3,
    credito:                4,
    recebimento_emprestimo: 5,
    vendas:                 6,
    recebimento_ted:        7,
    recebimento_doc:        8,
    aluguel:                9
  }, _prefix:            true

  # Validações dos campos obrigatórios
  validates :transaction_type, :date, :value, :cpf, :card, :hour, presence: true

  scope :incoming, -> { where(transaction_type: [ 1, 4, 5, 6, 7, 8 ]) }
  scope :outgoing, -> { where(transaction_type: [ 2, 3, 9 ]) }

  def self.total_balance
    incoming.sum(:value) - outgoing.sum(:value)
  end

  # Define se a transação é de entrada (+) ou saída (-)
  def incoming?
    transaction_type.in?(%w[debito credito recebimento_emprestimo vendas recebimento_ted recebimento_doc])
  end

  # Define se a transação é de saída (-)
  def outgoing?
    !incoming?
  end

  # Converte o valor de centavos para reais
  def value_in_reais
    value / 100.0
  end
end
