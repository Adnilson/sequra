require "test_helper"
require "disbursement_amount"

class DisbursementAmountTest < Minitest::Test
  def test_calculate
    assert_equal 9.90, DisbursementAmount.new(10).calculate
  end
end
