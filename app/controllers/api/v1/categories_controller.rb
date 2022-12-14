class Api::V1::CategoriesController < ApplicationController
  def index
    @categories = Category.all.order(:name)
    render json: @categories
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find(params[:id])
    render json: @category
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)

    if @category.valid?
      render json: @category, status: :created
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    render json: @category
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
