class DisbursementsController < ApplicationController
  include Pagy::Backend

  def index
    render json: pagy(Repositories::DisbursementRepository.all)
  end
end
