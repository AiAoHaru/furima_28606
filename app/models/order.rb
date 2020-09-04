class Order < ApplicationRecord
  validates :price, presence: true
  validates :token, presence: true
end
