class Disbursement < ApplicationRecord
  validates :reference, uniqueness: true

  scope :in_last_month, -> (merchant_reference) {
    where(
      "merchant_reference = ? AND created_at BETWEEN ? AND ?",
      merchant_reference, 1.month.ago.beginning_of_month , 1.month.ago.end_of_month
    )
  }
end
