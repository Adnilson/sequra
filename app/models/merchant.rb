class Merchant < ApplicationRecord
  validates :reference, uniqueness: true
end
