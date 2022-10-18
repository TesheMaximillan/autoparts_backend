class Api::V1::ProductsController < ApplicationController
  include CurrentUserConcern

  def index
    @products = Product.all
    render json: @products
  end

  def create
    @product = Product.new(product_params)
    @product.user = @current_user

    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
    render json: @product
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)

    if @product.valid?
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    render json: @product
  end

  private

  def product_params
    params.require(:product).permit(:user_id, :name, :part_number, :category_id, :stock_id, :cost, :selling, :quantity)
  end
end
