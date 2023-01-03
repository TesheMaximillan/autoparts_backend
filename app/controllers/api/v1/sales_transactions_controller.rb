class Api::V1::SalesTransactionsController < ApplicationController
  def index
    @sales_transactions = SalesTransaction.all
    sales_transactions = @sales_transactions.map do |sales_transaction|
      [
        sales_transaction,
        sales_transaction.sales
      ]
    end
    render json: sales_transactions
  end

  def create
    @sales_transaction = SalesTransaction.new(sales_transaction_params)

    if @sales_transaction.save
      render json: @sales_transaction, status: :created
    else
      render json: { errors: @sales_transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @sales_transaction = SalesTransaction.find(params[:id])
    render json: @sales_transaction
  end

  def update
    @sales_transaction = SalesTransaction.find(params[:id])
    @sales_transaction.update(sales_transaction_params)

    if @sales_transaction.valid?
      render json: @sales_transaction, status: :created
    else
      render json: { errors: @sales_transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @sales_transaction = SalesTransaction.find(params[:id])
    @sales_transaction.destroy
    render json: @sales_transaction
  end

  private

  def sales_transaction_params
    params.permit(:customer_id, :transaction_number, :reference_number, :po_number,
                  :delivery_number, :date, :received_by, :status, :vat, :withold, :other_costs)
  end
end
