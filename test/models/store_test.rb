require "test_helper"

class StoreTest < ActiveSupport::TestCase
  def setup
    @store = stores(:store_one)
  end

  test "deve ser válido com nome e dono" do
    assert @store.valid?
  end

  test "não deve ser válido sem nome" do
    @store.name = nil
    assert_not @store.valid?, "A loja deve ter um nome"
  end

  test "não deve ser válido sem dono" do
    @store.owner = nil
    assert_not @store.valid?, "A loja deve ter um dono"
  end

  test "deve permitir ter transações associadas" do
    transaction = transactions(:transaction_one)
    assert_includes @store.transactions, transaction, "A transação deveria estar associada à loja"
  end
end
