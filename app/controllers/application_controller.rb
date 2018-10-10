class ApplicationController < ActionController::Base
  # helper_method :check_credentials, :get_current_user, :team?, :validated?

  # checks to see if there is user with email address. If so sets session token, if not makes user and sets token
  def check_credentials
    user = get_current_user
    if user
      set_session_token(user)
    else
      new_user = User.new(email: params[:email])
      if new_user.save
        set_session_token(new_user)
      else
        render json: ["FORBIDDEN"], status: 403
      end
    end
  end

  # Checks to see if user is part of a team
  def team?
    user = get_current_user
    team = user.team
    return true if user.team
    render json: ["You cannot read, or write to a team that you are not part of"], status: 403
  end

  # this method is a little redundant because of how if the wrong email is entered it will make a new account. If that changes thought this will validate email with token
  def validated?
    user = nil
    token = nil
    if params[:id]
      user = User.find_by_id(params[:id])
    elsif params[:email]
      user = User.find_by_email(params[:email])
    elsif params[:auth_token]
      token = UserAuthorizationToken.find_by_token(params[:auth_token])
      if token
        user = token.user
      end
    else
      token = UserAuthorizationToken.find_by_token(session[:session_token])
      user = token.user
    end
    if user
      if user.show_token == session[:session_token]
        return true
      else
        return render json: ["FORBIDDEN"], status: 403
      end
    else
      render json: ["FORBIDDEN"], status: 403
    end
  end

  # sets the token on the users browser locally so that they don't have to keep entering credentials
  def set_session_token(user)
    session[:session_token] = user.show_token
  end

  # gets the current user from email, id, or auth_token params, or the current session_token
  def get_current_user
    user = nil
    token = nil
    if params[:id]
      user = User.find_by_id(params[:id])
    elsif params[:email]
      user = User.find_by_email(params[:email])
    elsif params[:auth_token]
      token = UserAuthorizationToken.find_by_token(params[:auth_token])
      if token
        user = token.user
      end
    else
      token = UserAuthorizationToken.find_by_token(session[:session_token])
      if token
        user = token.user
      end
    end
    user
  end

end
