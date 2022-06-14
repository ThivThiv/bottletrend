class Batch < ApplicationRecord
  belongs_to :domain
  has_many :bottles
end
