class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @batches = Batch.all
    @domains = Domain.all
  end

  def collection
    @private_bottles = current_user.kept_bottles_by_batch
    @on_resale_bottles = current_user.on_resale_bottles_by_batch
  end
end
