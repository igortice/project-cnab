class TransactionsController < ApplicationController
  before_action :get_stores,
                :get_transactions,
                only: %i[index]

  def index
    @total_sum      = @transactions.sum(:value)
    @total_balance  = @transactions.total_balance
    @total_incoming = @transactions.incoming.sum(:value)
    @total_outgoing = @transactions.outgoing.sum(:value)

    @pagy, @transactions = pagy(@transactions)
  end

  private

  def get_stores
    @stores = Store.order(:name)
  end

  def get_transactions
    @transactions = Transaction.includes(:store).order(date: :desc)
    @transactions = @transactions.where(store_id: transaction_params[:store_id]) if transaction_params[:store_id].present?
  end

  def transaction_params
    params.permit(:store_id, :date, :value, :cpf, :card, :hour)
  end
end
