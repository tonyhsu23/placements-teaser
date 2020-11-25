class VersionsController < ApplicationController
  def index
    @versions   = manage(Version.includes(:user).joins(:user))
    @item_types = Version.select(:item_type).distinct.map(&:item_type)
  end

  def show
    @version = Version.find(params[:id])
  end
end
