require "swagger_helper"

RSpec.describe "Transações API", type: :request do
  path "/api/transactions" do
    get "Lista todas as transações" do
      tags "Transações"
      produces "application/json"

      response "200", "Transações listadas" do
        run_test!
      end
    end
  end

  path "/api/transactions/{id}" do
    get "Mostra uma transação específica" do
      tags "Transações"
      produces "application/json"
      parameter name: :id, in: :path, type: :integer, description: "ID da transação"

      response "200", "Transação encontrada" do
        let(:id) { Transaction.create(transaction_type: "debito", date: "2024-02-01", value: 1000, cpf: "12345678900", card: "1234****5678", hour: "120000", store: Store.create(name: "Loja Teste", owner: "João")).id }
        run_test!
      end

      response "404", "Transação não encontrada" do
        let(:id) { 0 }
        run_test!
      end
    end
  end
end
