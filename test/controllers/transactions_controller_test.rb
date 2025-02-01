require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @store       = stores(:store_one)
    @transaction = transactions(:transaction_one)
  end

  test "deve acessar a página de transações" do
    get transactions_url
    assert_response :success
    assert_select "h1", "Transações"
  end

  test "deve filtrar transações por loja" do
    get transactions_url, params: { store_id: @store.id }
    assert_response :success
    assert_select "td", text: @store.name
  end
  #
  test "deve exibir saldo total corretamente" do
    get transactions_url, params: { store_id: @store.id }
    assert_response :success
    assert_match /Saldo Final:/, response.body
  end
end
