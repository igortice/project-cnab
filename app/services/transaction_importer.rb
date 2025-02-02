require "dry/monads"

class TransactionImporter
  extend Dry::Monads::Result::Mixin

  def self.import_line(line)
    # Parse a linha do arquivo CNAB
    parsed_data = CnabParser.parse_line(line)
    return Failure("Erro ao processar linha") unless parsed_data.success?

    # Valida os dados parseados
    validated_data = CnabValidator.new.call(parsed_data.value!)
    return Failure(validated_data.errors.to_h) unless validated_data.success?

    # Encontra ou cria a loja com base nos dados validados
    store = Store.find_or_create_by!(
      name:  validated_data[:store_name],
      owner: validated_data[:store_owner]
    )

    # Verifica se a transação já existe antes de tentar criar
    transaction = store.transactions.find_by(
      transaction_type: validated_data[:transaction_type],
      date:             validated_data[:date],
      hour:             validated_data[:hour],
      value:            validated_data[:value],
      cpf:              validated_data[:cpf],
      card:             validated_data[:card]
    )

    # Retorna a transação existente se encontrada
    return Success(transaction) if transaction.present?

    # Cria uma nova transação
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
    # Trata erro de transação duplicada
    Failure("Transação duplicada detectada pelo banco")
  rescue StandardError => e
    # Trata outros erros
    Failure(e.message)
  end
end
