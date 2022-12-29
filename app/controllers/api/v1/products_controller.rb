class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]
  before_action :ret_products, only: %i[index update]
  def index
    @products = @products.map do |product|
      quantity = StockProduct.where(product_id: product.id).pluck(:quantity).sum
      {
        id: product.id,
        name: product.name,
        part_number: product.part_number,
        brand: product.brand,
        status: product.status,
        selling: product.selling,
        cost: product.cost,
        category_id: product.category_id,
        quantity:
      }
    end

    render json: @products.compact
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      StockProduct.create(stock_id: params[:stock_id], product_id: @product.id, quantity: params[:quantity])
      json_result = {
        id: @product.id,
        name: @product.name,
        part_number: @product.part_number,
        brand: @product.brand,
        status: @product.status,
        selling: @product.selling,
        cost: @product.cost,
        category_id: @product.category_id,
        quantity: params[:quantity]
      }
      render json: json_result, status: :created
    else
      render json: { errors: @product.errors.messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @product
  end

  def update
    @product.update(product_params)
    @stock_transaction = StockProduct.where(stock_id: params[:stock_id], product_id: @product.id).first

    if @product.valid?
      if @stock_transaction
        @stock_transaction.update(quantity: params[:quantity])
      else
        StockProduct.create(stock_id: params[:stock_id], product_id: @product.id, quantity: params[:quantity])
      end
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    product_id = params[:id].split(',')[0]
    stock_id = params[:id].split(',')[1]
    StockProduct.where(stock_id:, product_id:).first.update(quantity: 0)
    render json: { message: 'Product deleted successfully!!!' }
  end

  private

  def product_params
    params.require(:product).permit(:name, :part_number, :brand, :status, :selling, :cost, :category_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def ret_products
    @products = Product.all
  end
end
