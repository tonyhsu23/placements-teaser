class CampaignsController < ApplicationController
  before_action :set_campaigns

  def index
    @campaigns = manage(@campaigns)
  end

  def show
    @campaign = sort(@campaigns).find(params[:id])
  end

  def update_status
    @campaign = @campaigns.find(params[:id])
    return @status = 'unreviewable' if !@campaign.reviewable?

    @campaign.send("#{params[:event]}!")
  rescue AASM::InvalidTransition
    @status = 'failure'
  end

  private

  def set_campaigns
    @campaigns = Campaign.includes(:line_items)
  end
end
