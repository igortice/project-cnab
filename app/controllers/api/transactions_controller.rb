class Api::TransactionsController < ApplicationController
  before_action :set_transaction, only: [ :show ]

  # GET /api/transactions
  def index
    transactions = Transaction.includes(:store)

    transactions = transactions.where(store_id: params[:store_id]) if params[:store_id].present?

    render json: transactions, only: [ :id, :date, :value, :cpf, :card, :hour ], include: { store: { only: [ :name, :owner ] } }
  end

  # GET /api/transactions/:id
  def show
    render json: @transaction
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Transação não encontrada" }, status: :not_found
  end
end
