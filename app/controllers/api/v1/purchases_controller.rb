class Api::V1::PurchasesController < ApplicationController
  include CurrentUserConcern

  def index
    @purchases = Purchase.all
    render json: @purchases
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.user = @current_user

    if @purchase.save
      render json: @purchase, status: :created
    else
      render json: { errors: @purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @purchase = Purchase.find(params[:id])
    render json: @purchase
  end

  def update
    @purchase = Purchase.find(params[:id])
    @purchase.update(purchase_params)

    if @purchase.valid?
      render json: @purchase, status: :created
    else
      render json: { errors: @purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy
    render json: @purchase
  end

  private

  def purchase_params
    params.require(:purchase).permit(:user_id, :date, :vendor_name, :reference_number, :quantity, :price)
  end
end