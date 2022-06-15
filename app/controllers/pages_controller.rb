class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @batches = Batch.all
    @domains = Domain.all
  end

  def collection
    @user = current_user
    batches = []
    batches_on_resale = []

    @user.bottles.each do |bottle|
      if bottle.on_resale
        batches_on_resale << bottle.batch
      else
        batches << bottle.batch
      end
    end
    batches.uniq!
    batches_on_resale.uniq!

    @batches_with_quantity = batches.map do |batch|
      {
        batch_name: batch.name,
        quantity: @user.batch_quantity(batch)
      }
    end

    @batches_on_resale_with_quantity = batches_on_resale.map do |batch|
      {
        batch_name: batch.name,
        quantity: @user.batch_quantity(batch)
      }
    end
  end
end
