class BookmarksController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def new

  end

  def create
    @bookmark = current_user.bookmarks.build(bookmarkable_type: params[:bookmarkable_type], bookmarkable_id: params[:bookmarkable_id])
    if @bookmark.bookmarkable && @bookmark.save
      redirect_to :back, notice: "Bookmark created!"
    else
      flash[:error] = "Bookmark could not be created!"
      redirect_to :back
    end
  end

  def destroy
    begin
      @bookmark = Bookmark.find(params[:id])
      if @bookmark.destroy
        redirect_to :back, notice: "Bookmark destroyed!"
      end
    rescue
      flash[:error] = "Bookmark could not be deleted!"
      redirect_to :back
    end
  end

  private

  def bookmark_params
  end
end
