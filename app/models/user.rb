class User < ApplicationRecord
  has_many :transactions
  has_many :bottles, through: :transactions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def batch_quantity(batch)
    self.bottles.where(batch: batch).count
  end

  def curently_owned_transactions
    transactions = Transaction.order(created_at: :desc)
    last_transactions = []
    owned_bottles = []
    transactions.each do |t|
      if !owned_bottles.include?(t.bottle)
        owned_bottles << t.bottle
        last_transactions << t
      end
    end
    return last_transactions.select do |t|
      t.user == self
    end
  end

  def kept_bottles
    bottles_array = self.curently_owned_transactions.select do |t|
      !t.on_resale
    end.map(&:bottle)
    Bottle.where(id: bottles_array.map(&:id))
  end

  def kept_bottles_by_batch
    self.kept_bottles.group(:batch).count
  end

  def on_resale_bottles
    bottles_array = self.curently_owned_transactions.select do |t|
      t.on_resale
    end.map(&:bottle)
    Bottle.where(id: bottles_array.map(&:id))
  end

  def on_resale_bottles_by_batch
    self.on_resale_bottles.group(:batch).count
  end

  def can_sell_from_batch?(batch)
    kept_bottles_by_batch.has_key?(batch) && batch.available_domain_stock == 0
  end
end
