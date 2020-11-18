class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.includes(:line_items)
    @campaigns = Pagination.new(@campaigns, paginate_params).paginate
  end

  def show
    @campaign = Campaign.includes(:line_items).find(params[:id])
  end
end
