class UsersController < Clearance::UsersController

  private

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    name = user_params.delete(:name)
    artistic_name = user_params.delete(:artistic_name)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.name = name
      user.artistic_name = artistic_name
    end
  end
end
