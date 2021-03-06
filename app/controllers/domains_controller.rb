class DomainsController < ApplicationController
  before_action :set_domain, only: [:show]
  def index
    @domains = Domain.all
  end

  def show

  end

  private

  def set_domain
    @domain = Domain.find(params[:id])
  end

  def batch_params
    params.require(:batch).permit(:photo)
  end
end
