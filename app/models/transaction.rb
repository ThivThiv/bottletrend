class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :bottle
  before_create :set_price

  def set_price
    self.price ||= Bottle.find(self.bottle_id).batch.initial_price
  end

  def sold_between_users?
    !self.bottle.transactions.blank?
  end

  def self.compute_price(old_price, batch)
    price = old_price * (1 + ((batch.domain.popularity / 5) + (120/batch.quantity)**1.5 + (batch.quality / 5)**2 + (batch.potential / 5)**1.5) / 100)
    price.round
  end

  def self.build_for_bottles(bottles, user)
    transactions = []
    bottles.each do |bottle|
      transaction = Transaction.new
      transaction.user = user
      # added price to transaction if domain sales
      balance = user.balance
      transaction.bottle = bottle
<<<<<<< HEAD
      transaction.price = bottle.batch.initial_price
      if user.balance > transaction.price
        transaction.save
        balance -= transaction.price
        user.update(balance: balance)
        transactions << transaction
      else
        flash.alert = "no money"
=======
      if transaction.sold_between_users?
        old_price = bottle.last_transaction.price
        transaction.price = self.compute_price(old_price, bottle.batch)
>>>>>>> origin
      end
      return transactions
      # comment these for algorithm
      # if !bottle.transactions.blank?
      #   transaction.price = 900 # a calculer en fct des dernières transaction + algo
      # end
    end
  end

  # def self.deduct_balance
  #     user = current_user
  #     price = transaction.price
  #     user.balance = user.balance - price
  #   end
  # end


end
