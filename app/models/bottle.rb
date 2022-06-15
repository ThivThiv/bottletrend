class Bottle < ApplicationRecord
  belongs_to :batch
  has_many :transactions, dependent: :destroy

end
