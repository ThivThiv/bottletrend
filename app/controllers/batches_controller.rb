class BatchesController < ApplicationController
  before_action :set_batch, only: [:show]

  def index
    if params[:query].present?
      @batches = Batch.global_search(params[:query])
    else
      @batches = Batch.all
    end
  end

  def show
    @transaction = Transaction.new
    @domain = Domain.find(@batch.domain_id)
    @current_user_bottles = current_user.kept_bottles_by_batch[@batch]
  end

  private

  def batch_params
    params.require(:batch).permit(:quantity, :initial_price, :domain_id, :name, :description, :year, :potential, :region, :photo)
  end

  def set_batch
    @batch = Batch.find(params[:id])
  end
end
