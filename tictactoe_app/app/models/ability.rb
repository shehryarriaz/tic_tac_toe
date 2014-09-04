class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :admin
        can :manage, :all
    elsif user.role? :basic_user
        can :read, Game
        can :create, Game
        can :read, Move
        can :create, Move
    else
        can :create, User
    end
  end
end
