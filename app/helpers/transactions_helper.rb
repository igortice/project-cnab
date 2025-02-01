module TransactionsHelper
  TRANSACTION_TYPES = {
    debito:                 "Débito",
    boleto:                 "Boleto",
    financiamento:          "Financiamento",
    credito:                "Crédito",
    recebimento_emprestimo: "Recebimento Empréstimo",
    vendas:                 "Vendas",
    recebimento_ted:        "Recebimento TED",
    recebimento_doc:        "Recebimento DOC",
    aluguel:                "Aluguel"
  }.freeze

  def human_transaction_type(transaction)
    TRANSACTION_TYPES[transaction.transaction_type.to_sym] || "Desconhecido"
  end
end
