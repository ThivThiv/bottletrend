class Bottle < ApplicationRecord
  belongs_to :batch
  has_many :transactions, dependent: :destroy

  def self.find_or_create_for_batch(batch, quantity)
    if batch.available_domain_stock > 0
      create_for_batch(batch, quantity)
    else
      find_for_batch(batch, quantity)
    end
  end

  def self.create_for_batch(batch, quantity)
    bottles = []
    quantity.to_i.times do
      bottles << Bottle.create(batch: batch)
    end
    return bottles
  end

  def last_transaction
    self.transactions.order(created_at: :desc).first
  end

  def current_owner
    if self.last_transaction
      self.last_transaction.user
    else
      nil
    end
  end

  def self.find_for_batch(batch, quantity)
    bottles = batch.bottles
    # on récupère la dernière transaction de chaque bouteille
    bottles_last_transactions = bottles.map(&:last_transaction)
    # on selectionne seulement les transaction (titre de propriété) disponible à la revente
    bottles_transactions_on_resale = bottles_last_transactions.select do |transaction|
      transaction.on_resale
    end
    # on récupère les N (quantity) bouteilles correspondant à ces transactions
    return bottles_transactions_on_resale.map do |transaction|
      transaction.bottle
    end.first(quantity)
  end

end
