class PlaylistSelectionsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def new

  end

  def create
    @playlist_selection = PlaylistSelection.new(playlist_selection_params)
    if @playlist_selection.save
      redirect_to :back, notice: "Added to playlist"
    else
      flash[:error] = "Could not add to playlist"
      redirect_to :back
    end
  end

  def destroy
    begin
      @playlist_selection = PlaylistSelection.find(params[:id])
      if @playlist_selection.destroy
        redirect_to :back, notice: "Removed from playlist"
      end
    rescue
      flash[:error] = "Could not remove from playlist"
      redirect_to :back
    end
  end

  private

  def playlist_selection_params
    params.require(:playlist_selection).permit(:song_id, :playlist_id)
  end
end
