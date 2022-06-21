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
      transaction.bottle = bottle
      if !bottle.transactions.blank?
        transaction.price = 900 # a calculer en fct des dernières transaction + algo
      end
      transaction.save
      transactions << transaction
    end
  end

  def self.resell_current_user_bottles

  end
end
