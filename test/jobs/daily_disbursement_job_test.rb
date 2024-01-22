require 'test_helper'

class DailyDisbursementJobTest < ActiveJob::TestCase
  include ActiveSupport::Testing::TimeHelpers

  def setup
    @merchant = Merchant.create(
      reference: "jonas_brothers_band",
      email: "jonas_brothers_band@hotmail.com",
      live_on: "2023-03-21",
      disbursement_frequency: "DAILY",
      minimum_monthly_fee: 29.99
    )

    Order.create(
      merchant_reference: @merchant.reference,
      amount: 33.00
    )
    Order.create(
      merchant_reference: @merchant.reference,
      amount: 33.04
    )
    Order.create(
      merchant_reference: @merchant.reference,
      amount: 63.22
    )
    Order.create(
      merchant_reference: @merchant.reference,
      amount: 33.04
    )
  end

  def teardown
    Merchant.delete_all
    Order.delete_all
    Disbursement.delete_all
    MinimumMonthlyFee.delete_all
  end

  test "disbursement is created" do
    perform_enqueued_jobs do
      DailyDisbursementJob.perform_later
    end

    disbursement = Disbursement.first
    order = Order.find_by(merchant_reference: disbursement.merchant_reference)
    
    assert_equal 4, Order.count
    assert_equal 1, Disbursement.count
    assert_equal 160.71, disbursement.amount
    assert_equal 1.59, disbursement.fee
    assert_equal "jonas_brothers_band", disbursement.merchant_reference
    assert_equal disbursement.reference, order.disbursement_reference
  end

  test "check minimum monthly fee" do
    travel_to Date.new(2024, 01, 01) do
      perform_enqueued_jobs do
        DailyDisbursementJob.perform_later
      end

      assert_equal @merchant.minimum_monthly_fee, MinimumMonthlyFee.first.amount
    end
  end
end
