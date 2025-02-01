require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  require "test_helper"

  class TransactionTest < ActiveSupport::TestCase
    def setup
      @debito                 = transactions(:transaction_debito)
      @boleto                 = transactions(:transaction_boleto)
      @financiamento          = transactions(:transaction_financiamento)
      @credito                = transactions(:transaction_credito)
      @recebimento_emprestimo = transactions(:transaction_recebimento_emprestimo)
      @vendas                 = transactions(:transaction_vendas)
      @recebimento_ted        = transactions(:transaction_recebimento_ted)
      @recebimento_doc        = transactions(:transaction_recebimento_doc)
      @aluguel                = transactions(:transaction_aluguel)
    end

    test "todas as transações devem ser válidas" do
      assert @debito.valid?
      assert @boleto.valid?
      assert @financiamento.valid?
      assert @credito.valid?
      assert @recebimento_emprestimo.valid?
      assert @vendas.valid?
      assert @recebimento_ted.valid?
      assert @recebimento_doc.valid?
      assert @aluguel.valid?
    end

    test "identificação correta de transações de entrada" do
      assert @debito.incoming?, "Débito deveria ser identificado como entrada"
      assert @credito.incoming?, "Crédito deveria ser identificado como entrada"
      assert @recebimento_emprestimo.incoming?, "Recebimento de empréstimo deveria ser identificado como entrada"
      assert @vendas.incoming?, "Vendas deveriam ser identificadas como entrada"
      assert @recebimento_ted.incoming?, "Recebimento via TED deveria ser identificado como entrada"
      assert @recebimento_doc.incoming?, "Recebimento via DOC deveria ser identificado como entrada"
    end

    test "identificação correta de transações de saída" do
      assert @boleto.outgoing?, "Boleto deveria ser identificado como saída"
      assert @financiamento.outgoing?, "Financiamento deveria ser identificado como saída"
      assert @aluguel.outgoing?, "Aluguel deveria ser identificado como saída"
    end

    test "conversão correta de valor em reais" do
      assert_equal 150.00, @debito.value_in_reais
      assert_equal 50.00, @boleto.value_in_reais
      assert_equal 300.00, @financiamento.value_in_reais
      assert_equal 200.00, @credito.value_in_reais
      assert_equal 250.00, @recebimento_emprestimo.value_in_reais
      assert_equal 175.00, @vendas.value_in_reais
      assert_equal 275.00, @recebimento_ted.value_in_reais
      assert_equal 80.00, @recebimento_doc.value_in_reais
      assert_equal 300.00, @aluguel.value_in_reais
    end
  end
end
