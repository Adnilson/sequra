class Disbursement < ApplicationRecord
  validates :reference, uniqueness: true
end
