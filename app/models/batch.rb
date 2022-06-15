class Batch < ApplicationRecord
  has_many :bottles
  belongs_to :domain
end
