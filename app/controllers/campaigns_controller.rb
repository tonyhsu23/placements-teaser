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

    if @campaign.reviewable?
      @campaign.send("#{params[:event]}!")
      flash[:success] = "#{@campaign.reload.status} successfully"
    else
      flash[:warning] = 'Line Items must all be reviewed first'
    end

  rescue AASM::InvalidTransition
    flash[:warning] = 'Invalid status transition'
  end

  private

  def set_campaigns
    @campaigns = Campaign.includes(:line_items)
  end
end
