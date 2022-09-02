class SearchController < ApplicationController
  before_action :require_login
  def index
    q = Author.ransack(user_artistic_name_or_music_title_cont_any: params[:q].split(" "))
    @authors = q.result.includes(:user, :music)
    organize_data
    respond_to do |format|
      format.turbo_stream { render "search/index", status: :ok }
    end
  end

  private

  def organize_data
    @json = []
    @authors.each do |author|
      @json.append({
        "name": author.music.title,
        "artist": "Artist Name",
        "url": url_for(author.music.music),
        "cover_art_url": url_for(author.music.image_cover)
      })
    end
  end
end
