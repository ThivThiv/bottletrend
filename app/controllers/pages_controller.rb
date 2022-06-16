class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @batches = Batch.all
    @domains = Domain.all
  end

  def collection
    @private_bottles = current_user.bottles.group(:batch).where(on_resale: true).count
    @private_batches = @private_bottles.keys

    @on_resale_bottles = current_user.bottles.group(:batch).where(on_resale: false).count
    @on_resale_batches = @on_resale_bottles.keys
  end
end
