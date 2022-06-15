class Batch < ApplicationRecord
  has_many :bottle
  belongs_to :domain


end
