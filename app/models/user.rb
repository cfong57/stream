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
  #users are prompted when deleting their account whether all uploads are deleted, or
  #moved to the public pool (where all uploads are anonymous and untagged)
  #admins can choose whether to do that or not when deleting an account manually

  before_create :set_member
  before_destroy :transfer_songs

  #mount_uploader :song, SongUploader 
  #may experiment later with uploading audio directly

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

  ROLES = %w[member admin]
  def role?(base_role)
    role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
  end  

  private

  def set_member
    self.role = 'member'
  end

  #.public_user returns nil
  def transfer_songs
    if self.make_public_on_delete
      self.songs.each { |song| song.user = User.public_user }
    end
  end

end
