class SearchController < ApplicationController
  def index
    q = Author.ransack(user_artistic_name_or_music_title_cont_any: params[:q].split(" "))
    @authors = q.result.includes(:user, :music)
    respond_to do |format|
      format.turbo_stream { render "search/index", status: :ok }
    end
  end
end
