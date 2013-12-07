class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name,
  :provider, :uid, :public, :make_public_on_delete

  #has_many :tags, dependent: :destroy
  has_many :songs, dependent: :destroy
  #songs are deleted when a user is deleted, unless they change make_public_on_delete to true
  #in that case, the songs are moved to the anon pool (nil user_id)
  #admins can change this option before deleting a user

  before_create :set_member
  before_destroy :transfer_songs, prepend: true

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  #people who log in via facebook etc won't have a password in our database
  unless(:provider)
    validates :password, presence: true
  end
  
  #mount_uploader :song, SongUploader 
  #may experiment later with uploading audio directly

  # Overly complex code to count user uploads - not sure how to make work with other sorts yet
  # Select all attributes of the user
  # Count the uploads made by the user (users with 0 songs will not show up)
  # Ties the songs table to the users table, via the user_id
  # Instructs the database to group the results so that each user will be returned in a distinct row
  # Instructs the database to order the results in descending order
  def self.uploads
    self.select('users.*'). 
    select('COUNT(DISTINCT songs.id) AS songs_count'). 
    joins(:songs). 
    group('users.id'). 
    order('songs_count DESC') 
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      pass = Devise.friendly_token[0,20]
      user = User.new(name: auth.extra.raw_info.name,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         password: pass,
                         password_confirmation: pass
                        )
      user.skip_confirmation!
      user.save
    end
    user
  end

  ROLES = %w[member moderator admin]
  def role?(base_role)
    role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
  end  

  private

  def set_member
    self.role = 'member'
  end

  def transfer_songs
    if self.make_public_on_delete
      spoink = self.id
      songs = Song.where("user_id = ?", spoink)
      songs.each do |song|
        song.update_attribute(:user_id, nil)
        song.update_attribute(:public, true)
      end
    end
  end

end