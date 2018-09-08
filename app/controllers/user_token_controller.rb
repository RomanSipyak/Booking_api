=begin
class UserTokenController < Knock::AuthTokenController
=end

class UserTokenController < ApplicationController


  def create
    user = User.new(auth_params)
    if p user.save
      auth_token = Knock::AuthToken.new(payload: { sub: user.id })
      render json: { user: user, auth_token: auth_token.token }
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def auth_params
    params.require(:auth).permit :username,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :city_id,
                                 :image
  end
end
