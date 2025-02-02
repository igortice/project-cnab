class Api::TransactionsController < ApplicationController
  before_action :set_transaction, only: [ :show ]

  # GET /api/transactions
  def index
    transactions       = Transaction.includes(:store).order(date: :desc)
    transactions       = transactions.where(store_id: transaction_params[:store_id]) if transaction_params[:store_id].present?
    pagy, transactions = pagy(transactions)

    render json: TransactionSerializer.new(transactions, include: [ :store ])
                                      .serializable_hash
                                      .merge(pagination: pagy_metadata(pagy))
  end

  # GET /api/transactions/:id
  def show
    render json: TransactionSerializer.new(@transaction, include: [ :store ]).serializable_hash
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Transação não encontrada" }, status: :not_found
  end

  def transaction_params
    params.permit(:store_id, :date, :value, :cpf, :card, :hour)
  end
end
