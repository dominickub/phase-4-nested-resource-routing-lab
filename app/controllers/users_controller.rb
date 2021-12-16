class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def show
    user = User.find_by(id: params[:id])
    render json: user, include: :items
  end

  def index
    users = User.all
    render json: users
  end

  def create
    users = User.create(users_params)
    render json: users
  end

  private

  def users_params
    params.permit(:username, :city)
  end

  def render_not_found_response
    render json: { error: "404" }, status: :not_found
  end

end
