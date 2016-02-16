class SongsController < ApplicationController
  def new
  end

  def edit
  end

  def show
    @song = Song.find(params[:id])
    @playlist_selection = PlaylistSelection.new(song: @song)
  end

  def index
  end

  def bookmark
    @song = Song.find(params[:id])
    current_user.bookmarked_songs << @song
    redirect_to :back
  end

  def unbookmark
    @song = Song.find(params[:id])
    current_user.bookmarked_songs.delete @song
    redirect_to :back
  end
end
