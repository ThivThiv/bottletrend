class Domain < ApplicationRecord
  has_many :batches, dependent: :destroy
  has_one_attached :photo
end
