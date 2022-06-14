class Bottle < ApplicationRecord
  belongs_to :batch
  has_many :transactions
end
