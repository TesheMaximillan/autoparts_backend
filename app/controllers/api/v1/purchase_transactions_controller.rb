class Api::V1::PurchaseTransactionsController < ApplicationController
  def index
    @purchase_transactions = PurchaseTransaction.all
    purchase_transactions = @purchase_transactions.map do |purchase_transaction|
      [
        purchase_transaction,
        purchase_transaction.purchases
      ]
    end
    render json: purchase_transactions
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
    @purchase_transaction.purchases.map do |purchase|
      stock_product = StockProduct.where(stock_id: purchase.stock_id, product_id: purchase.product_id).first
      if stock_product.quantity >= purchase.quantity
        stock_product.update(quantity: stock_product.quantity - purchase.quantity)
      else
        render json: { message: 'Not enough stock' }, status: :unprocessable_entity
      end
    end
    @purchase_transaction.destroy
    render json: @purchase_transaction
  end

  private

  def purchase_transaction_params
    params.permit(:vendor_id, :transaction_number, :reference_number, :po_number,
                  :delivery_number, :date, :received_by, :status, :vat, :withold, :other_costs)
  end
end
