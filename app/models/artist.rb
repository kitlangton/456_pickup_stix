class Artist < ActiveRecord::Base
  validates :name, presence: true
  has_many :songs
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy
end
