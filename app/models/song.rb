class Song < ActiveRecord::Base
  belongs_to :user
  #has_and_belongs_to_many :tags
  attr_accessible :name, :audio, :info, :public

  #mount_uploader :audio, SongUploader
  #maybe later

  default_scope order('created_at DESC')
  scope :visible_to, lambda { |user| Ability.new(user).can?(:read, self) ? scoped : joins(:song).where('song.public = true') }

  validates :name, presence: true, uniqueness: {scope: :user_id}
  validates :audio, presence: true  

  auto_html_for :audio do
    html_escape
    image
    youtube(:width => 400, :height => 250)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

end
