require "swagger_helper"
require_relative "schemas/transactions_schema"
require_relative "schemas/transaction_schema"
require_relative "schemas/store_schema"

RSpec.describe "Transações API", type: :request do
  path "/api/transactions" do
    get "Lista todas as transações com paginação e filtro por loja" do
      tags "Transações"
      produces "application/vnd.api+json"
      parameter name: :page, in: :query, type: :integer, description: "Número da página (default: 1)"
      parameter name: :store_id, in: :query, type: :integer, description: "Filtrar por loja específica"

      response "200", "Transações listadas" do
        schema TransactionsSchema.schema

        let!(:store) { create(:store) }
        let!(:transactions) { create_list(:transaction, 15, store: store) }

        let(:page) { 1 }
        let(:store_id) { store.id }

        run_test! do |response|
          json = JSON.parse(response.body)

          # ✅ Verifica se a resposta contém um array de transações
          expect(json["data"]).to be_an(Array)

          # ✅ Verifica se cada transação tem os atributos esperados
          json["data"].each do |transaction|
            expect(transaction).to have_key("id")
            expect(transaction).to have_key("type")
            expect(transaction["attributes"]).to have_key("date")
            expect(transaction["attributes"]).to have_key("value")
          end

          # ✅ Testa a paginação
          expect(json["pagination"]["count"]).to eq(15)
          expect(json["pagination"]["page"]).to eq(page)
        end
      end
    end
  end

  path "/api/transactions/{id}" do
    get "Mostra uma transação específica" do
      tags "Transações"
      produces "application/vnd.api+json"
      parameter name: :id, in: :path, type: :integer, description: "ID da transação"

      response "200", "Transação encontrada" do
        schema TransactionSchema.schema

        let(:id) { create(:transaction, transaction_type: "debito", store: create(:store)).id }

        run_test! do |response|
          json = JSON.parse(response.body)

          # ✅ Verifica se a resposta tem os dados corretos
          expect(json["data"]).to have_key("id")
          expect(json["data"]["attributes"]).to have_key("date")
          expect(json["data"]["attributes"]).to have_key("value")
          expect(json["data"]["attributes"]["transaction_type"]).to eq("debito")
        end
      end

      response "404", "Transação não encontrada" do
        let(:id) { 0 }

        run_test! do |response|
          json = JSON.parse(response.body)

          # ✅ Verifica se a resposta retorna um erro apropriado
          expect(response.status).to eq(404)
          expect(json["error"]).to eq("Transação não encontrada")
        end
      end
    end
  end
end
