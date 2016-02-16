class PlaylistSelection < ActiveRecord::Base
  belongs_to :song
  belongs_to :playlist
  validates :song, :playlist, presence: true
end
