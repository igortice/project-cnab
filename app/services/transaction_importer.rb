require "dry/monads"

class TransactionImporter
  extend Dry::Monads::Result::Mixin

  def self.import_line(line)
    parsed_data = CnabParser.parse_line(line)
    return Failure("Erro ao processar linha") unless parsed_data.success?

    validated_data = CnabValidator.new.call(parsed_data.value!)
    return Failure(validated_data.errors.to_h) unless validated_data.success?

    store = Store.find_or_create_by!(
      name:  validated_data[:store_name],
      owner: validated_data[:store_owner]
    )

    # 🔹 Verificando se a transação já existe antes de tentar criar
    transaction = store.transactions.find_by(
      transaction_type: validated_data[:transaction_type],
      date:             validated_data[:date],
      hour:             validated_data[:hour],
      value:            validated_data[:value],
      cpf:              validated_data[:cpf],
      card:             validated_data[:card]
    )

    return Success(transaction) if transaction.present?

    transaction = store.transactions.create!(
      transaction_type: validated_data[:transaction_type],
      date:             validated_data[:date],
      hour:             validated_data[:hour],
      value:            validated_data[:value],
      cpf:              validated_data[:cpf],
      card:             validated_data[:card]
    )

    Success(transaction)
  rescue ActiveRecord::RecordNotUnique
    Failure("Transação duplicada detectada pelo banco")
  rescue StandardError => e
    Failure(e.message)
  end
end
