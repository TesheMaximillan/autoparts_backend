class Api::V1::SettingsController < ApplicationController
  def index
    @settings = Setting.all
    render json: @settings
  end

  def create
    @setting = Setting.new(setting_params)

    if @setting.save
      render json: @setting, status: :created
    else
      render json: { errors: @setting.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @setting = Setting.find(params[:id])
    @setting.update(setting_params)

    if @setting.valid?
      render json: @setting, status: :created
    else
      render json: { errors: @setting.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def setting_params
    params.require(:setting)
      .permit(:company_name, :main_store, :selling_in_percent,
              :vat, :withould, :other_tax, :fs_number, :po_number,
              :delivery_number, :received_by, :status, :brand, :cost,
              :selling)
  end
end
