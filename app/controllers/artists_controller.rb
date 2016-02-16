class ArtistsController < ApplicationController
  def new
  end

  def edit
  end

  def index
    @artists = Artist.all
  end

  def show
    @artist = Artist.find(params[:id])
    if current_user
      @playlist_selection = PlaylistSelection.new
      @playlists = current_user.playlists
    end
  end
end
