require "test_helper"

class TransactionImporterTest < ActiveSupport::TestCase
  def setup
    @valid_line   = "3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO       "
    @invalid_line = "X201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO       "
  end

  test "deve importar uma transação válida" do
    result = TransactionImporter.import_line(@valid_line)

    assert result.success?, "A transação deveria ser importada"
    transaction = result.value!

    assert_equal "BAR DO JOÃO", transaction.store.name
    assert_equal "JOÃO MACEDO", transaction.store.owner
    assert_equal 0, transaction.transaction_type.to_i
    assert_equal Date.new(2019, 3, 1), transaction.date
    assert_equal 14200, transaction.value
    assert_equal "09620676017", transaction.cpf
    assert_equal "4753****3153", transaction.card
    assert_equal "15:34:53", transaction.hour
  end

  test "deve falhar ao importar uma linha CNAB inválida" do
    result = TransactionImporter.import_line(@invalid_line)

    assert result.failure?, "Deveria falhar ao processar linha inválida"
    assert_kind_of Hash, result.failure, "O erro deveria ser um Hash"
    assert result.failure[:transaction_type], "Deveria haver um erro no tipo da transação"
  end

  test "não deve duplicar transações existentes" do
    TransactionImporter.import_line(@valid_line)
    result = TransactionImporter.import_line(@valid_line)

    assert result.success?, "Deveria evitar duplicação"
    assert_equal 11, Transaction.count, "Deveria haver apenas uma transação no banco"
  end
end
