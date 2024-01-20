class CreateWeeklyDisbursementJob < ApplicationJob
  queue_as :high

  def perform(merchant_reference)
    Repositories::DisbursementRepository.create(merchant_reference)
  end
end