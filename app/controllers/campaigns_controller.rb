class CampaignsController < ApplicationController
  include ResourceManageable

  before_action :set_campaigns

  def index
    @campaigns = manage(@campaigns)
  end

  def show
    @campaign = sort(@campaigns).find(params[:id])
  end

  private

  def set_campaigns
    @campaigns = Campaign.includes(:line_items)
  end
end
