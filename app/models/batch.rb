class Batch < ApplicationRecord
  has_many :bottle
  belong_to :domain
end
