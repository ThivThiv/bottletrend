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
    price = old_price * (1 + ((batch.domain.popularity / 5) + (50/batch.quantity)**1.5 + (batch.quality / 5)**2 + (batch.potential / 5)**1.5) / 100)
    price.round
  end

  def self.build_for_bottles(bottles, user)
    transactions = []
    bottles.each do |bottle|
      transaction = Transaction.new
      transaction.user = user
      balance = user.balance
      transaction.bottle = bottle
      transaction.price = bottle.batch.current_price

      if transaction.sold_between_users?
        old_price = transaction.price
        transaction.price = self.compute_price(old_price, bottle.batch)
      end

      if user.balance > transaction.price
        transaction.save
        transactions << transaction
        balance -= transaction.price
        user.update(balance: balance)

      # else
        # flash.now[:alert] = "Contactez nous pour recharger votre wallet!"
      end
    end

    return transactions
  end
end
