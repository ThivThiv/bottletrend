class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @batches = Batch.all
    @domains = Domain.all
  end

  def my_wallet
    @user = current_user
    @my_wallet = @user.wallet
  end
end
