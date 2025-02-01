class TransactionsController < ApplicationController
  before_action :get_stores, only: %i[index]

  def index
    @transactions  = Transaction.includes(:store).order(date: :desc)

    @transactions  = @transactions.where(store_id: params[:store_id]) if params[:store_id].present?
    @total_sum     = @transactions.sum(:value)
    @total_balance = @transactions.total_balance
  end

  private

  def get_stores
    @stores = Store.order(:name)
  end
end
