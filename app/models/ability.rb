class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    # guests can see stuff but only upload to the "public pool", no management options or tagging

    # Members can upload publicly or to their own pool, manage their own stuff freely
    # read: if public (same as guests) OR if my own 
    if user.role? :member
      can :read, User, :user_id => user.id
      can :read, Song, :user_id => user.id
      can :update, Song, :user_id => user.id
      can :destroy, Song, :user_id => user.id
      can :create, Tag
      can :read, Tag, :user_id => user.id
      can :update, Tag, :user_id => user.id
      can :destroy, Tag, :user_id => user.id
    end  

    # Admins can do anything, including deleting others' stuff and viewing private things
    # Because public pool songs have a nil user, only admins can edit/delete them
    if user.role? :admin
      can :manage, :all
    end
    
    can :create, Song
    can :read, Song, public: true
    can :read, Tag, public: true
    can :read, User, public: true
  end
end