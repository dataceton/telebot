class Order < ApplicationRecord
  has_one :product
  belongs_to :user
end
