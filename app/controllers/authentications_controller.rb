class AuthenticationsController < ApplicationController
  def create
    if user = User.find_by(email: auth['info']['email'])
      session[:user_id] = user.id
    else
      user = User.create(email: auth['info']['email'], name: auth['info']['name'], password: SecureRandom.hex)
    end

    session[:user_id] = user.id

    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
