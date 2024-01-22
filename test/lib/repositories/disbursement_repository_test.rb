require "test_helper"

module Repositories
  class DisbursementRepositoryTest < Minitest::Test
    def teardown
      Merchant.delete_all
      Order.delete_all
      Disbursement.delete_all
    end

    def test_create
      merchant1 = Merchant.create(
        reference: "jonas_brothers_band",
        email: "jonas_brothers_band@hotmail.com",
        live_on: "2023-03-21",
        disbursement_frequency: "DAILY",
        minimum_monthly_fee: 0.0
      )

      merchant2 = Merchant.create(
        reference: "houthala_lala",
        email: "houthala_lala@hotmail.com",
        live_on: "2024-01-03",
        disbursement_frequency: "DAILY",
        minimum_monthly_fee: 0.0
      )

      Order.create(
        merchant_reference: merchant1.reference,
        amount: 33.00
      )
      Order.create(
        merchant_reference: merchant1.reference,
        amount: 33.04
      )
      Order.create(
        merchant_reference: merchant1.reference,
        amount: 63.22
      )
      Order.create(
        merchant_reference: merchant1.reference,
        amount: 33.04
      )
      Order.create(
        merchant_reference: merchant2.reference,
        amount: 33.04
      )
      Order.create(
        merchant_reference: merchant2.reference,
        amount: 1239.99
      )
      Order.create(
        merchant_reference: merchant2.reference,
        amount: 96.25
      )

      disbursement1 = Repositories::DisbursementRepository.create(merchant1.reference)
      order1 = Order.find_by(merchant_reference: disbursement1.merchant_reference)

      disbursement2 = Repositories::DisbursementRepository.create(merchant2.reference)
      order2 = Order.find_by(merchant_reference: disbursement2.merchant_reference)

      assert_equal 2, Disbursement.count
      assert_equal 7, Order.where(disbursed: true).count

      assert_equal 160.71, disbursement1.amount
      assert_equal 1.59, disbursement1.fee
      assert_equal "jonas_brothers_band", disbursement1.merchant_reference
      assert_equal disbursement1.reference, order1.disbursement_reference

      assert_equal 1357.50, disbursement2.amount
      assert_equal 11.78, disbursement2.fee
      assert_equal "houthala_lala", disbursement2.merchant_reference
      assert_equal disbursement2.reference, order2.disbursement_reference
    end
  end
end
