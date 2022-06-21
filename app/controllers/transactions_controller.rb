class TransactionsController < ApplicationController

  def new
    @batch = Batch.find(params[:batch_id])
    @transaction = Transaction.new
  end

  def resale
    @batch = Batch.find(params[:batch_id])
    @transaction = Transaction.new
    @my_bottles_count = current_user.batch_quantity(@batch)
    @my_bottles = current_user.current_owned_bottle(@batch)
  end

  def create_resale
    quantity = params[:batch][:quantity].to_i
    @batch = Batch.find(params[:batch_id])
    @my_bottles_count = current_user.batch_quantity(@batch)
    @my_bottles = current_user.current_owned_bottle(@batch)
    if quantity <= @my_bottles_count
      bottle_on_resale = @my_bottles.take(quantity)
      bottle_on_resale.each do |bottle|
        bottle.transactions.last.update(on_resale: true)
        bottle.transactions.last.save
      end
    else
      render :new
    end
    redirect_to batch_path(@batch)
  end

  def create
    @batch = Batch.find(params[:batch_id])
    # si les bouteilles sont vendues par le domaine
    # je crée les bouteilles à partir de la quantité souhaitée
    ActiveRecord::Base.transaction do
      @bottles = Bottle.find_or_create_for_batch(@batch, params[:transaction][:quantity].to_i)
      Transaction.build_for_bottles(@bottles, current_user)
    end
    redirect_to collection_path
  end

  def update
    @batch = Batch.find(params[:batch_id])
    @bottles = Bottle.find_for_batch(@batch, params[:transaction][:quantity].to_i)
  end

  private

  def transaction_params
    params.require(:transaction).permit(:quantity, :bottle_id, :user_id, :on_resale)
  end
end
