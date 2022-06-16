class TransactionsController < ApplicationController

  def new
    @batch = Batch.find(params[:batch_id])
    @transaction = Transaction.new
  end


  def create
    @bottles = create_bottles(params[:transaction][:quantity])
    @bottles.each do |bottle|
      @transaction = Transaction.new
      @transaction.user = current_user
      @transaction.bottle = bottle
      @transaction.save
    end
    redirect_to collection_path
  end

  private
  def create_bottles(quantity)
    bottles = []
    @batch = Batch.find(params[:batch_id])
    quantity.to_i.times do
      bottles << Bottle.create(batch: @batch)
      @batch.save
    end
    return bottles
  end

  def transaction_params
    params.require(:transaction).permit(:quantity, :bottle_id, :user_id)
  end
end
