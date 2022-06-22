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
    @users_stock = @batch.available_users_stock - current_user.on_resale_bottles_by_batch[@batch].to_i
    @stock = @batch.available_domain_stock.positive? ? @batch.available_domain_stock : @users_stock
    @display_stock = "#{@stock} #{@batch.available_domain_stock.positive? ? '(Domaine)' : '(Utilisateurs)'}"
    @can_buy = @stock.positive?
  end

  private

  def batch_params
    params.require(:batch).permit(:quantity, :initial_price, :domain_id, :name, :description, :year, :potential, :region, :photo)
  end

  def set_batch
    @batch = Batch.find(params[:id])
  end
end
