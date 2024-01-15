module Repositories
  class MerchantRepository
    def self.weekly_disbursed
      Merchant.includes(:orders).where("disbursement_frequency = ? AND EXTRACT(DOW FROM live_on) = ?", "WEEKLY", Date.today.wday)
    end

    def self.daily_disbursed
      Merchant.includes(:orders).where(disbursement_frequency: "DAILY").where(orders: { disbursed: false })
    end
  end
end
