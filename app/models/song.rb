class Song < ActiveRecord::Base
  belongs_to :user
  #has_and_belongs_to_many :tags
  attr_accessible :name, :audio, :info, :public

  #mount_uploader :audio, SongUploader
  #maybe later

  default_scope order('updated_at DESC')
  scope :visible_to, lambda { |user| user ? scoped : joins(:song).where('song.public = true') }

  #would rather users edit a current song than re-up and delete
  #of course, if two different users try to upload something with the same name.......
  validates :name, presence: true, uniqueness: true
  validates :audio, presence: true  

  auto_html_for :audio do
    html_escape
    image
    youtube(:width => 400, :height => 250)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

end
