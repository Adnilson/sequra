module Repositories
  class MerchantRepository
    def self.weekly_disbursed
      Merchant.where("disbursement_frequency = ? AND EXTRACT(DOW FROM live_on) = ?", "WEEKLY", Date.today.wday)
    end

    def self.daily_disbursed
      Merchant.where(disbursement_frequency: "DAILY")
    end
  end
end
