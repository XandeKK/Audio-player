class HomeController < ApplicationController
  before_action :require_login
  
  def index
    @recents =  Author.order("created_at DESC").limit(10).includes(:user, :music, :image_cover_blob, :music_blob)
    @random = Author.order("RANDOM()").limit(10).includes(:user, :music, :image_cover_blob, :music_blob)
  end
end
