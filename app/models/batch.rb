class Batch < ApplicationRecord
  has_many :bottles, dependent: :destroy
  belongs_to :domain
  has_one_attached :photo

end
