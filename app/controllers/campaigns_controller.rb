class CampaignsController < ApplicationController
  def show
    @campaign = Campaign.includes(:line_items).find(params[:id])
  end
end
