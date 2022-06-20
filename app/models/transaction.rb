class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :bottle
  before_create :set_price

  def set_price
    self.price ||= Bottle.find(self.bottle_id).batch.initial_price
  end

  def self.build_for_bottles(bottles, user)
    transactions = []
    bottles.each do |bottle|
      transaction = Transaction.new
      transaction.user = user
      # added price to transaction si domain sales
      transaction.price = bottle.batch.initial_price
      balance = user.balance
      balance -= transaction.price
      # if !bottle.transactions.blank?
      #   transaction.price = 900 # a calculer en fct des dernières transaction + algo
      # end
      transaction.save
      user.update(balance: balance)
      transactions << transaction
    end
  end

  # def self.deduct_balance
  #     user = current_user
  #     price = transaction.price
  #     user.balance = user.balance - price
  #   end
  # end


end
