class CampaignsController < ApplicationController
  def show
    @campaign = Campaign.find_by(params[:id])
  end
end
