=begin
class UserTokenController < Knock::AuthTokenController
=end

class UserTokenController < ApplicationController


  def create
    user = User.new(auth_params)
    if p user.save
      auth_token = Knock::AuthToken.new(payload: { sub: user.id })
      response.headers['Authorization'] = "#{auth_token.token}"
      render json: { user: user }
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
