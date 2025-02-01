require "test_helper"

class CnabValidatorTest < ActiveSupport::TestCase
  def setup
    @valid_data = {
      transaction_type: 3,
      date:             Date.new(2019, 3, 1),
      value:            142,
      cpf:              "09620676017",
      card:             "753****3153",
      hour:             "15:31:53",
      store_owner:      "JOÃO MACEDO",
      store_name:       "BAR DO JOÃO"
    }

    @invalid_data = {
      transaction_type: 99, # Tipo inválido
      date: nil, # Data ausente
      value: -500, # Valor negativo
      cpf: "12345", # CPF inválido
      card: nil, # Cartão ausente
      hour: "99:99:99", # Hora inválida
      store_owner: "",
      store_name:  ""
    }
  end

  test "deve validar dados corretamente" do
    result = CnabValidator.new.call(@valid_data)
    assert result.success?, "Os dados deveriam ser válidos"
  end

  test "deve retornar erros para dados inválidos" do
    result = CnabValidator.new.call(@invalid_data)
    assert result.failure?, "A validação deveria falhar"
    assert result.errors.to_h[:cpf], "CPF deveria ser inválido"
    assert result.errors.to_h[:date], "Data deveria ser obrigatória"
    assert result.errors.to_h[:value], "Valor deveria ser positivo"
  end
end
