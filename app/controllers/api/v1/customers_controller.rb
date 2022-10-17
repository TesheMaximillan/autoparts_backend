class Api::V1::CustomersController < ApplicationController
  include CurrentUserConcern

  def index
    @customers = Customer.all
    render json: @customers
  end
  
  def create
    @customer = Customer.new(customer_params)
    @customer.user = @current_user

    if @customer.save
      render json: @customer, status: :created
    else
      render json: { errors: @customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @customer = Customer.find(params[:id])
    render json: @customer
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)

    if @customer.valid?
      render json: @customer, status: :created
    else
      render json: { errors: @customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    render json: @customer
  end

  private

  def customer_params
    params.require(:customer).permit(:user_id, :name)
  end
end

