class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Asegúrate de tener un usuario actual incluso si no se ha iniciado sesión

    can :create, Category
    can :manage, Category, author: { id: user.id }
    can :manage, Atransaction
  end
end
