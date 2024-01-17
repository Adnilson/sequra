require "test_helper"

module Repositories
  class MerchantRepositoryTest < Minitest::Test
    include ActiveSupport::Testing::TimeHelpers

    def setup
      Merchant.create(
        reference: "jonas_brothers_band",
        email: "jonas_brothers_band@hotmail.com",
        live_on: "2023-03-21",
        disbursement_frequency: "DAILY",
        minimum_monthly_fee: 0.0
      )

      Merchant.create(
        reference: "houthala_lala",
        email: "houthala_lala@hotmail.com",
        live_on: "2024-01-03",
        disbursement_frequency: "DAILY",
        minimum_monthly_fee: 0.0
      )

      Merchant.create(
        reference: "luke_ground_walker",
        email: "luke_ground_walker@hotmail.com",
        live_on: "2023-03-21",
        disbursement_frequency: "WEEKLY",
        minimum_monthly_fee: 0.0
      )
    end

    def teardown
      Merchant.delete_all
    end

    def test_weekly_disbursed
      travel_to Date.new(2024, 01, 02) do
        merchants = Repositories::MerchantRepository.weekly_disbursed

        assert_equal 1, merchants.count
      end
    end

    def test_daily_disbursed
      merchants = Repositories::MerchantRepository.daily_disbursed

      assert_equal 2, merchants.count
    end
  end
end
