require "swagger_helper"

RSpec.describe "Transações API", type: :request do
  path "/api/transactions" do
    get "Lista todas as transações com paginação e filtro por loja" do
      tags "Transações"
      produces "application/json"
      parameter name: :page, in: :query, type: :integer, description: "Número da página (default: 1)"
      parameter name: :store_id, in: :query, type: :integer, description: "Filtrar por loja específica"

      response "200", "Transações listadas" do
        schema type:       :object,
               properties: {
                 transactions: {
                   type:  :array,
                   items: {
                     type:       :object,
                     properties: {
                       id:    { type: :integer },
                       date:  { type: :string, format: :date },
                       value: { type: :integer },
                       cpf:   { type: :string },
                       card:  { type: :string },
                       hour:  { type: :string },
                       store: {
                         type:       :object,
                         properties: {
                           name:  { type: :string },
                           owner: { type: :string }
                         }
                       }
                     }
                   }
                 },
                 pagination:   {
                   type:       :object,
                   properties: {
                     total_count:  { type: :integer },
                     current_page: { type: :integer },
                     total_pages:  { type: :integer },
                     next_page:    { type: [ :integer, "null" ] },
                     prev_page:    { type: [ :integer, "null" ] }
                   }
                 }
               }

        let!(:store) { Store.create(name: "Loja Teste", owner: "João") }
        let!(:transactions) do
          create_list(:transaction, 15, store: store, transaction_type: "credito", value: 1000, cpf: "12345678900", card: "1234****5678", hour: "120000")
        end

        let(:page) { 1 }
        let(:per_page) { 5 }
        let(:store_id) { store.id }

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
