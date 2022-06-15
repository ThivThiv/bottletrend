class Domain < ApplicationRecord
  has_many :batches, dependent: :destroy
end
