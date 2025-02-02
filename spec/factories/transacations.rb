FactoryBot.define do
  factory :transaction do
    transaction_type { [ "credito", "debito", "boleto" ].sample }
    date { Faker::Date.between(from: "2023-01-01", to: "2024-12-31") }
    value { Faker::Number.between(from: 100, to: 10000) }
    cpf { Faker::Number.number(digits: 11).to_s }
    card { "1234****#{Faker::Number.number(digits: 4)}" }
    hour { "#{Faker::Number.between(from: 10, to: 23)}#{Faker::Number.between(from: 10, to: 59)}00" }
    association :store
  end
end
