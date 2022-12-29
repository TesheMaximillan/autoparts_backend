class Api::V1::StocksController < ApplicationController
  def index
    @stocks = Stock.all.order(name: :asc)
    render json: @stocks
  end

  def stocks_products
    @stocks_products = Stock.all.map do |stock|
      {
        stock:,
        products: stock.products.map do |product|
          {
            id: product.id,
            category_id: product.category_id,
            name: product.name,
            part_number: product.part_number,
            brand: product.brand,
            status: product.status,
            selling: product.selling,
            cost: product.cost,
            quantity: stock.stock_products.where(product_id: product.id).first.quantity
          }
        end
      }
    end

    render json: @stocks_products
  end

  def create
    @stock = Stock.new(stock_params)

    if @stock.save
      render json: @stock, status: :created
    else
      render json: { errors: @stock.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @stock = Stock.find(params[:id])
    render json: @stock
  end

  def update
    @stock = Stock.find(params[:id])
    @stock.update(stock_params)

    if @stock.valid?
      render json: @stock, status: :created
    else
      render json: { errors: @stock.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy
    render json: @stock
  end

  private

  def stock_params
    params.require(:stock).permit(:name)
  end
end
