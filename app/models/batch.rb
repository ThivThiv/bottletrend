class Batch < ApplicationRecord
  has_many :bottles, dependent: :destroy
  belongs_to :domain

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :description, :year, :region ],
    associated_against: {
      domain: [ :name, :description]
    },
    using: {
      tsearch: { prefix: true }
    }

  def available_stock
    self.quantity
    @bottles = Bottle.where(batch: self)
    @buyed_bottles = []
    @bottles.each do |bottle|
      @buyed_bottles << Transaction.where(bottle: bottle)
    end
    return self.quantity - @buyed_bottles.count
    raise
  end
end
