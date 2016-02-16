class User < ActiveRecord::Base
  before_create :generate_token
  validates :first_name, :last_name, :email, :first_name, presence: true
  validates :email, uniqueness: true
  has_secure_password
  has_many :playlist_selections

  # has_many :followings
  # has_many :followers, through: :followings

  has_many :playlists, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_songs, through: :bookmarks, source: :bookmarkable, source_type: 'Song'

  def full_name
    "#{first_name} #{last_name}"
  end

  def generate_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self.auth_token)
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def bookmark_song(song)
    self.bookmarks << song
  end

  def has_bookmark?(bookmarkable)
    self.bookmarks.exists?(bookmarkable_type: bookmarkable.class, bookmarkable_id: bookmarkable.id)
  end
end
