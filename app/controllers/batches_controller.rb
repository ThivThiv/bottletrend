class BatchesController < ApplicationController
  before_action :set_batch, only: [:show]

  def index
    @batches = Batch.all
  end

  def show
    @domain = Domain.find(@batch.domain_id)
  end

  private

  def batch_params
    params.require(:batch).permit(:quantity, :initial_price, :domain_id, :name, :description, :year, :potential, :region, :photo)
  end

  def set_batch
    @batch = Batch.find(params[:id])
  end
end
