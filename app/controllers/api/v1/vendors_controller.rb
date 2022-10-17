class Api::V1::VendorsController < ApplicationController
  include CurrentUserConcern

  def index
    @vendors = Vendor.all
    render json: @vendors
  end

  def create
    @vendor = Vendor.new(vendor_params)
    @vendor.user = @current_user

    if @vendor.save
      render json: @vendor, status: :created
    else
      render json: { errors: @vendor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @vendor = Vendor.find(params[:id])
    render json: @vendor
  end

  def update
    @vendor = Vendor.find(params[:id])
    @vendor.update(vendor_params)

    if @vendor.valid?
      render json: @vendor, status: :created
    else
      render json: { errors: @vendor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @vendor = Vendor.find(params[:id])
    @vendor.destroy
    render json: @vendor
  end

  private

  def vendor_params
    params.require(:vendor).permit(:user_id, :name)
  end
end
