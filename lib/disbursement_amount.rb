class DisbursementAmount
  FEES = {
    (0..49.99) => 1,
    (50..300) => 0.95,
    (300.01..) => 0.85
  }.freeze

  def initialize(amount)
    @amount = amount
  end

  def calculate
    (amount - (amount * fee_percentage)).round(2)
  end

  private

  def fee_percentage
    FEES.select { |range| range.include?(amount) }.values.first.to_f / 100
  end

  attr_reader :amount
end
