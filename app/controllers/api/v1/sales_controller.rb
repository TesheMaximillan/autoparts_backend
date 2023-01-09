class Api::V1::SalesController < ApplicationController
  def create
    transaction_id = SalesTransaction.where(transaction_number: params[:transaction_number]).first.id
    @sale = Sale.new(stock_id: params[:stock_id], sales_transaction_id: transaction_id,
                     product_id: params[:product_id], quantity: params[:quantity], price: params[:price])

    if @sale.save
      stock_product = StockProduct.where(stock_id: params[:stock_id], product_id: params[:product_id]).first

      if stock_product.quantity < params[:quantity].to_i
        render json: { message: 'Not enough quantity in your stock' }
      else
        stock_product.update(quantity: stock_product.quantity - params[:quantity])
        render json: @sale, status: :created
      end
    else
      render json: { errors: @sale.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @sale = Sale.find(params[:id])
    updated_quantity = @sale.quantity - params[:quantity].to_i
    if @sale.update(sale_params)
      stock_product = StockProduct.where(stock_id: @sale.stock_id, product_id: @sale.product_id).first
      stock_product.update(quantity: stock_product.quantity + updated_quantity)
      render json: @sale
    else
      render json: { errors: @sale.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @sale = Sale.find(params[:id])

    if @sale.destroy
      stock_product = StockProduct.where(stock_id: @sale.stock_id, product_id: @sale.product_id).first
      stock_product.update(quantity: stock_product.quantity + @sale.quantity)
      render json: { message: 'Sale deleted' }
    else
      render json: { errors: @sale.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:stock_id, :sales_transaction_id, :product_id, :quantity, :price)
  end
end
