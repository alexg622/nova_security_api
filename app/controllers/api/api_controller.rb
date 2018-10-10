class Api::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_credentials, :validated?
  before_action :team?, only: [:get_team, :update_team]

  # gets a specific user by email, id, or auth_token
  def get_user
    # sets the current user by params of id, email, current session token, or auth_token
    user = get_current_user
    if !user
      return render json: ["Could not find user"], status: 401
    end
    # if the user just created their account the auth_token will be sent back
    if (user.created_at - DateTime.now).abs < 01
      render json: {email: user.email, id: user.id, token: user.show_token}
    else
      render json: {email: user.email, id: user.id}
    end
  end

  # gets a specific team by id, and makes sure user is part of that team
  def get_team
    # gets users from params of email, id, current session token, or auth_token
    user = get_current_user
    if !user
      return render json: ["Could not find user"], status: 401
    end
    # gets the team that user is part of
    team = Team.find_by_id(params[:teamId])
    # double checks that the user is part of that team
    if user.team != team
      team = nil
    end
    if !team
      render json: ["Could not find a team for this user"], status: 401
    else
      # sends back the team members emails, and the team name and id
      team_members = team.members.map(&:email)
      render json: {team: team, team_members: team_members}
    end
  end

  # gets a team by id and lets user update it if part of that team
  def update_team
    team = Team.find_by_id(params[:teamId])
    # gets current user by email, id, current session token, or auth_token params
    user = get_current_user
    # double checks the user is part of that team
    if user.team != team
      return render json: ["You cannot read or write to a team that you aren't a part of"], status: 403
    end
    # updates team and then sends back team members emails, and the team name and id
    team.update(name: params[:name])
    if team.save
      team_members = team.members.map(&:email)
      render json: {team: team, team_members: team_members}
    else
      render json: {error: "Could not update team"}
    end
  end

end
