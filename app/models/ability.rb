class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    # guests can see stuff but only upload to the "public pool", no management options

    # Members can upload publicly or to their own pool, manage their own stuff freely
    if user.role? :member
      can :update, Song, :user_id => user.id
      can :destroy, Song, :user_id => user.id
    end  

    # Admins can do anything, including deleting others' stuff
    if user.role? :admin
      can :manage, :all
    end
    
    can :create, Song
    can :read, Song
  end
end