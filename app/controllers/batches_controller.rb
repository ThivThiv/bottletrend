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
    @domain = Domain.find(@batch.domain_id)
  end

  private

  def batch_params
    params.require(:batch).permit(:quantity, :initial_price, :domain_id, :name, :description, :year, :potential, :region)
  end

  def set_batch
    @batch = Batch.find(params[:id])
  end
end
