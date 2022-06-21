class TransactionsController < ApplicationController

  def new
    @batch = Batch.find(params[:batch_id])
    @transaction = Transaction.new
  end

  def create
    @batch = Batch.find(params[:batch_id])
    # si les bouteilles sont vendues par le domaine
    # je crée les bouteilles à partir de la quantité souhaitée
    @bottles = Bottle.find_or_create_for_batch(@batch, params[:transaction][:quantity].to_i)
    Transaction.build_for_bottles(@bottles, current_user)
    redirect_to collection_path
  end

  def update
    @batch = Batch.find(params[:batch_id])
    @bottles = Bottle.find_for_batch(@batch, params[:transaction][:quantity].to_i)
  end

  private

  def transaction_params
    params.require(:transaction).permit(:quantity, :bottle_id, :user_id)
  end
end
