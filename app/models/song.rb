class Song < ActiveRecord::Base
  has_many :tags, dependent: :destroy
  belongs_to :user
  attr_accessible :name, :audio, :public

  #mount_uploader :audio, SongUploader
  #maybe later

  default_scope order('updated_at DESC')
  scope :visible_to, lambda { |user| user ? scoped : joins(:song).where('song.public = true') }

  validates :name, presence: true
  validates :audio, presence: true  

end
