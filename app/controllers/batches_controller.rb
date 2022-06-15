class BatchesController < ApplicationController
  def index
    @batches = Batch.all
  end

  def batch_params
    params.require(:batch).permit(:quantity, :initial_price, :domain_id, :name, :description, :year, :potential, :region)
  end
end
