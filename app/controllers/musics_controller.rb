class MusicsController < ApplicationController
  before_action :require_login
  before_action :set_music, except: [:new, :create]
  before_action :redirect_if_empty, except: [:new, :create]

  def new
    @music = Music.new
  end

  def create
    @music = Music.new(music_params)

    if @music.save
      @music.authors.create!(user: current_user, music: @music)
      redirect_to music_path(@music)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @music.update(music_params)
      redirect_to music_path(@music)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @music.destroy
      redirect_to root_path
    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  private

  def music_params
    params.require(:music).permit(
      :title,
      :image_cover,
      :music,
      authors_attributes: [ :user_id ],
      music_categories_attributes: [ :category_id ]
    )
  end

  def set_music
    @music = Music.joins(:authors).find_by(id: params[:id], "authors.user": current_user)
  end

  def redirect_if_empty
    redirect_to root_path if @music.nil?
  end
end
