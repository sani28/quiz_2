#this file helps us define all authorization rules for our application
#we can use these rules in our controllers and views throughout our application

class Ability
  include CanCan::Ability

  #we don't need to initalize an instance of the `Ability` class ourselves,
  #this is automatically done for us by the CanCanCan gem. The only thing we
  # need to make sure of is that we have a method in the controller called `current_user`
  # that returns an object of the currently logged in user (we already have that)

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    #it is usually reccommended that you intialize the `user` argument to a new user
    # so ew don't have to check if `user` is nil all the time.

    user ||= User.new  #conditional assignment operator more common than >  #user = User.new unless user.present? <


    #in this rule we're saying: the user can `manage` meaning do any action on
    #the idea object if `idea.user == user` which means if the owner of
    #the idea is currently the signed in user
    can :manage, Idea do |idea|
      idea.user == user
    end

    can :destroy, Idea do |idea|
      idea.user == user
    end


    #remember that this only defines the rules, you still have to enforce the rules
    #yourself, by actually using those rules in the controllers and views
    # the advantage is that all of our authorization rules are in one file so we
    #only have to come and change this file when authorization rules change


    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
