class Api::V1::PurchaseTransactionsController < ApplicationController
  def index
    @purchase_transactions = PurchaseTransaction.all
    render json: @purchase_transactions
  end

  def create
    @purchase_transaction = PurchaseTransaction.new(purchase_transaction_params)

    if @purchase_transaction.save
      render json: @purchase_transaction, status: :created
    else
      render json: { errors: @purchase_transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @purchase_transaction = PurchaseTransaction.find(params[:id])
    render json: @purchase_transaction
  end

  def update
    @purchase_transaction = PurchaseTransaction.find(params[:id])
    @purchase_transaction.update(purchase_transaction_params)

    if @purchase_transaction.valid?
      render json: @purchase_transaction, status: :created
    else
      render json: { errors: @purchase_transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @purchase_transaction = PurchaseTransaction.find(params[:id])
    @purchase_transaction.destroy
    render json: @purchase_transaction
  end

  private

  def purchase_transaction_params
    params.permit(:vendor_id, :transaction_number, :reference_number, :po_number,
                  :delivery_number, :date, :received_by, :status, :vat, :withold, :other_costs)
  end
end
