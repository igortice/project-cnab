require "test_helper"

class CnabProcessorTest < ActiveSupport::TestCase
  def setup
    @valid_file_path = Rails.root.join("test/fixtures/files/valid_cnab.txt")
    @invalid_file_path = Rails.root.join("test/fixtures/files/invalid_cnab.txt")
    @empty_file_path = Rails.root.join("test/fixtures/files/empty_cnab.txt")
  end

  test "deve processar corretamente um arquivo CNAB válido" do
    result = CnabProcessor.process(@valid_file_path)

    assert result.success?, "O processamento deveria ser bem-sucedido"
    assert_equal 3, result.value![:transactions_saved], "Deveria salvar 3 transações"
  end

  test "deve falhar se o arquivo não existir" do
    result = CnabProcessor.process("caminho/inexistente.txt")

    assert result.failure?, "Deveria falhar ao processar um arquivo inexistente"
    assert_equal "🚨 Arquivo não encontrado", result.failure
  end

  test "deve falhar se todas as linhas do CNAB forem inválidas" do
    result = CnabProcessor.process(@invalid_file_path)

    assert result.failure?, "O processamento deveria falhar"
    assert_equal 0, result.failure[:transactions_saved], "Nenhuma transação deveria ser salva"
    assert result.failure[:errors].any?, "Deveria haver erros no processamento"
  end

  test "deve falhar se o arquivo for vaio" do
    result = CnabProcessor.process(@empty_file_path)

    assert result.failure?, "O processamento deveria falhar"
    assert_equal "⚠️ Arquivo vazio", result.failure
  end
end
