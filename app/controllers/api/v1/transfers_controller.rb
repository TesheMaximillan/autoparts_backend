class Api::V1::TransfersController < ApplicationController
  def index
    @transfers = Transfer.all.order(date: :desc)
    render json: @transfers
  end

  def create
    from_stock_id = params[:transfer][:from]
    to_stock_id = params[:transfer][:to]
    product_id = params[:transfer][:product_id]
    quantity = params[:transfer][:quantity]
    qty = StockProduct.where(stock_id: from_stock_id, product_id:).first.quantity

    @transfer = Transfer.new(transfer_params)
    if qty >= quantity
      if @transfer.save
        transfer(from_stock_id, to_stock_id, product_id, quantity)
        render json: @transfer, status: :created
      else
        render json: { errors: @transfer.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: ['Not enough stock'] }, status: :unprocessable_entity
    end
  end

  def update
    @transfer = Transfer.find(params[:id])
    from_stock_id = @transfer.to
    to_stock_id = @transfer.from
    product_id = @transfer.product_id
    quantity = @transfer.quantity

    @transfer.update(transfer_params)

    if @transfer.valid?
      transfer(from_stock_id, to_stock_id, product_id, quantity)
      transfer(params[:transfer][:from], params[:transfer][:to], params[:transfer][:product_id],
               params[:transfer][:quantity])
      render json: @transfer, status: :created
    else
      render json: { errors: @transfer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @transfer = Transfer.find(params[:id])
    render json: @transfer
  end

  def destroy
    @transfer = Transfer.find(params[:id])
    from_stock_id = @transfer.to
    to_stock_id = @transfer.from
    product_id = @transfer.product_id
    quantity = @transfer.quantity

    transfer(from_stock_id, to_stock_id, product_id, quantity)

    @transfer.destroy
    render json: @transfer
  end

  private

  def transfer_params
    params.require(:transfer).permit(:product_id, :from, :to, :date, :quantity)
  end

  def transfer(from, to, id, qty)
    remove_from_stock(from, id, qty)
    add_to_stock(to, id, qty)
  end

  def remove_from_stock(stock_id, product_id, qty)
    quantity = StockProduct.where(stock_id:, product_id:).first.quantity

    if quantity >= qty
      StockProduct.where(stock_id:, product_id:).first.update(quantity: quantity - qty)
    else
      render json: { errors: ['Not enough stock'] }, status: :unprocessable_entity
    end
  end

  def add_to_stock(stock_id, product_id, qty)
    if StockProduct.where(stock_id:, product_id:).first
      quantity = StockProduct.where(stock_id:, product_id:).first.quantity
      StockProduct.where(stock_id:, product_id:).first.update(quantity: quantity + qty)
    else
      StockProduct.create(stock_id:, product_id:, quantity: qty)
    end
  end
end
