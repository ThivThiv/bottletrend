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
end
