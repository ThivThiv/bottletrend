class Batch < ApplicationRecord
  has_many :bottles, dependent: :destroy
  belongs_to :domain
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :description, :year, :region ],
    associated_against: {
      domain: [ :name, :description]
    },
    using: {
      tsearch: { prefix: true }
    }

  def available_domain_stock
    @bottles = self.bottles
    @buyed_bottles = []
    @bottles.each do |bottle|
      @buyed_bottles << Transaction.where(bottle: bottle)
    end
    return self.quantity - @buyed_bottles.count
  end

  def available_users_stock
    self.bottles.map(&:last_transaction).select do |t|
      t.on_resale == true
    end.count
  end
end
