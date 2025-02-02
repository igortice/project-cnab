class TransactionSerializer
  include JSONAPI::Serializer

  attributes :date, :transaction_type, :value, :cpf, :card, :hour

  attribute :formatted_value do |transaction|
    "R$ #{'%.2f' % (transaction.value / 100.0)}"
  end

  belongs_to :store
end
