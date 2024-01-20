require 'test_helper'

class DailyDisbursementJobTest < ActiveJob::TestCase
  def setup
    merchant = Merchant.create(
      reference: "jonas_brothers_band",
      email: "jonas_brothers_band@hotmail.com",
      live_on: "2023-03-21",
      disbursement_frequency: "DAILY",
      minimum_monthly_fee: 0.0
    )

    Order.create(
      merchant_reference: merchant.reference,
      amount: 33.00
    )
    Order.create(
      merchant_reference: merchant.reference,
      amount: 33.04
    )
    Order.create(
      merchant_reference: merchant.reference,
      amount: 63.22
    )
    Order.create(
      merchant_reference: merchant.reference,
      amount: 33.04
    )
  end

  def teardown
    Merchant.delete_all
    Order.delete_all
    Disbursement.delete_all
  end

  test "disbursement is created" do
    perform_enqueued_jobs do
      DailyDisbursementJob.perform_later
    end

    disbursement = Disbursement.first
    
    assert_equal 4, Order.count
    assert_equal 1, Disbursement.count
    assert_equal 160.71, disbursement.amount
    assert_equal 1.59, disbursement.fee
    assert_equal "jonas_brothers_band", disbursement.merchant_reference
    assert_equal disbursement.reference, Order.find_by(merchant_reference: disbursement.merchant_reference).disbursement_reference
  end
end
