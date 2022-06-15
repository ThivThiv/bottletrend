class TransactionsController < ApplicationController
  def new
  end

  def create
    @batch = Batch.find(params[:batch_id])
    @transaction = Transaction.new(transaction_params)
    @transaction.batch = @batch
    @transaction.user = current_user
  end

  private

  def transaction_params
    params.require(:transaction).permit(:quantity, :batch_id)
  end
end
