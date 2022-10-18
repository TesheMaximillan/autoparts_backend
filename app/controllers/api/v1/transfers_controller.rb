class Api::V1::TransfersController < ApplicationController
  include CurrentUserConcern

  def index
    @transfers = Transfer.all
    render json: @transfers
  end

  def create
    @transfer = Transfer.new(transfer_params)
    @transfer.user = @current_user

    if @transfer.save
      render json: @transfer, status: :created
    else
      render json: { errors: @transfer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @transfer = Transfer.find(params[:id])
    render json: @transfer
  end

  def update
    @transfer = Transfer.find(params[:id])
    @transfer.update(transfer_params)

    if @transfer.valid?
      render json: @transfer, status: :created
    else
      render json: { errors: @transfer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @transfer = Transfer.find(params[:id])
    @transfer.destroy
    render json: @transfer
  end

  private

  def transfer_params
    params.require(:transfer).permit(:user_id, :date, :from, :to, :product_id, :quantity)
  end
end
