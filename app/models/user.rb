class User < ApplicationRecord
  has_many :transactions
  has_many :bottles, through: :transactions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def batch_quantity(batch)
    self.bottles.where(batch: batch).count
  end
end
