class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    # guests can see stuff but only upload to the "public pool", no management options or tagging

    # Members can upload publicly or to their own pool, manage their own stuff freely
    # read: if public (same as guests) OR if my own 
    # Because public pool songs have a nil user, only mods and admins can edit/delete them
    if user.role? :member
      can :read, User, :id => user.id
      can :read, Song, :user_id => user.id
      can :update, Song, :user_id => user.id
      can :destroy, Song, :user_id => user.id
      can :create, Tag
      can :read, Tag, :user_id => user.id
      can :update, Tag, :user_id => user.id
      can :destroy, Tag, :user_id => user.id
    end  

    # Moderators can do anything to stuff in the anonymous pool, since it will be the
    # most work to keep under control

    if user.role? :moderator
      can :manage, Song, :user_id => nil
      can :manage, Tag, :user_id => nil
    end

    # Admins can do anything, including deleting others' stuff and viewing private things
    
    if user.role? :admin
      can :manage, :all
    end
    
    can :create, Song
    can :read, Song, public: true
    can :read, Tag, public: true
    can :read, User, public: true
  end
end