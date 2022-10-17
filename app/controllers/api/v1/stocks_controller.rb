class Api::V1::StocksController < ApplicationController
  include CurrentUserConcern

  def index
    @stocks = Stock.all
    render json: @stocks
  end

  def create
    @stock = Stock.new(stock_params)
    @stock.user = @current_user

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
    params.require(:stock).permit(:user_id, :product_id,:name)
  end
end
