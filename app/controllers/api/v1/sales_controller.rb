class Api::V1::SalesController < ApplicationController
  include CurrentUserConcern

  def index
    @sales = Sale.all
    render json: @sales
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.user = @current_user

    if @sale.save
      render json: @sale, status: :created
    else
      render json: { errors: @sale.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @sale = Sale.find(params[:id])
    render json: @sale
  end

  def update
    @sale = Sale.find(params[:id])
    @sale.update(sale_params)

    if @sale.valid?
      render json: @sale, status: :created
    else
      render json: { errors: @sale.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy
    render json: @sale
  end

  private

  def sale_params
    params.require(:sale).permit(:user_id, :date, :customer_id, :product_id, :received_by, :reference_number, :quantity, :price, :status)
  end
end