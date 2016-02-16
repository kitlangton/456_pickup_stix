class PlaylistsController < ApplicationController
  before_action :require_login, except: [:show, :index]

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user = current_user
    if @playlist.save
      redirect_to @playlist, notice: "Playlist created!"
    else
      flash.now[:error] = "Playlist could not be saved."
      render :new
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def update
    @playlist = Playlist.find(params[:id])
    if @playlist.update(playlist_params)
      redirect_to @playlist, notice: "Playlist updated!"
    else
      flash.now[:error] = "Playlist could not be updated."
      render :edit
    end
  end

  def destroy
    begin
      @playlist = Playlist.find(params[:id])
      if @playlist.destroy
        redirect_to current_user, notice: "Playlist destroyed!"
      else
        flash[:error] = "Playlist could not be updated."
        redirect_to :back
      end
    rescue
      flash[:error] = "Playlist could not be updated."
      redirect_to :back
    end
  end

  def index
    @playlists = Playlist.all
  end

  def add_to
    @playlist = Playlist.find(params[:id])
    @song = Song.find(params[:song_id])
    @playlist.songs << @song
    redirect_to :back
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
