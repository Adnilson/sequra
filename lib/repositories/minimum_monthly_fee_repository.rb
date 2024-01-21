module Repositories
  class MinimumMonthlyFeeRepository
    def self.create(params)
      MinimumMonthlyFee.create(params)
    end
  end
end