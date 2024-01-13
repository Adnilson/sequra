class MerchantRepository
  def self.weekly_disbursements
    Merchant.includes(:orders).where("disbursement_frequency = ? AND DAYOFWEEK(live_on) = ?", "WEEKLY", Date.today.wday)
  end

  def self.daily_disbursements
    Merchant.includes(:orders).where(disbursement_frequency: "DAILY")
  end
end