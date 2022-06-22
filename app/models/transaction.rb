class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :bottle
  before_create :set_price
  validates :bottle, presence: true
  validates :user, presence: true

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
    transaction_price = bottles.first.batch.current_price
    computed_price = self.compute_price(transaction_price, bottles.first.batch)
    bottles.each do |bottle|
      transaction = Transaction.new
      transaction.user = user
      transaction.bottle = bottle

      if transaction.sold_between_users?
        transaction.price = computed_price
        seller = bottle.last_transaction.user
      end

      return transactions unless user.balance > transaction_price

      transaction.save
      transactions << transaction
      # DEBIT de l'acheteur
      user.credit(-transaction_price)
      # CRédite le vendeur si il existe
      if seller
        seller.credit(transaction_price)
      end
    end

    return transactions
  end
end
