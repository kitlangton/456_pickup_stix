class Playlist < ActiveRecord::Base
  has_many :playlist_selections, dependent: :destroy
  has_many :songs, through: :playlist_selections
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy
  belongs_to :user

  validates :name, :user, presence: true
end
