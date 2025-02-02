FactoryBot.define do
  factory :transacation do
    transaction_type { "credito" }
    date { "2024-02-01" }
    value { 1000 }
    cpf { "12345678900" }
    card { "1234****5678" }
    hour { "120000" }
    store
  end
end
