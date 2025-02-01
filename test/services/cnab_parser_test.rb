require "test_helper"

class CnabParserTest < ActiveSupport::TestCase
  def setup
    @valid_line = "3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO       "
  end

  test "deve extrair corretamente os dados de uma linha CNAB" do
    result = CnabParser.parse_line(@valid_line)

    assert result.success?, "A linha CNAB deveria ser processada corretamente"
    data = result.value!
    assert_equal 3, data[:transaction_type]
    assert_equal Date.new(2019, 3, 1), data[:date]
    assert_equal 14200, data[:value]
    assert_equal "09620676017", data[:cpf]
    assert_equal "4753****3153", data[:card]
    assert_equal "15:34:53", data[:hour]
    assert_equal "JOÃO MACEDO", data[:store_owner]
    assert_equal "BAR DO JOÃO", data[:store_name]
  end
end
