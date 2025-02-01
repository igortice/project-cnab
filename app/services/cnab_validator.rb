require "dry-validation"

class CnabValidator < Dry::Validation::Contract
  params do
    required(:transaction_type).filled(:integer, included_in?: (1..9).to_a)
    required(:date).filled(:date)
    required(:value).filled(:integer, gteq?: 0)
    required(:cpf).filled(:string, format?: /\A\d{11}\z/)
    required(:card).filled(:string)
    required(:hour).filled(:string, format?: /\A\d{2}:\d{2}:\d{2}\z/)
    required(:store_owner).filled(:string)
    required(:store_name).filled(:string)
  end
end
