class Api::V1::PurchasesController < ApplicationController
  def create
    transaction_id = PurchaseTransaction.where(transaction_number: params[:transaction_number]).first.id

    @purchase = Purchase.new(stock_id: params[:stock_id], purchase_transaction_id: transaction_id, product_id: params[:product_id], quantity: params[:quantity], price: params[:price])

    if @purchase.save
      stock_product = StockProduct.where(stock_id: params[:stock_id], product_id: params[:product_id]).first
      stock_product.update(quantity: stock_product.quantity + params[:quantity].to_i)
      render json: @purchase, status: :created
    else
      render json: { errors: @purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @purchase = Purchase.find(params[:id])
    updated_quantity = @purchase.quantity - params[:quantity].to_i
    if @purchase.update(purchase_params)
      stock_product = StockProduct.where(stock_id: @purchase.stock_id, product_id: @purchase.product_id).first
      stock_product.update(quantity: stock_product.quantity - updated_quantity)
      render json: @purchase
    else
      render json: { errors: @purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])

    if @purchase.destroy
      stock_product = StockProduct.where(stock_id: @purchase.stock_id, product_id: @purchase.product_id).first
      stock_product.update(quantity: stock_product.quantity - @purchase.quantity)
      render json: { message: 'Purchase deleted' }
    else
      render json: { errors: @purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
