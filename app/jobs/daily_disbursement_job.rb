class DailyDisbursementJob < ApplicationJob
  queue_as :high

  def perform(*args)
    Repositories::MerchantRepository.daily_disbursed.find_each do |merchant|
      CreateDailyDisbursementJob.perform_later(merchant.reference)
    end
  end
end
