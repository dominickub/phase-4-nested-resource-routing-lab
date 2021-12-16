class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items= user.items
    else
    items = Item.all
    end
    render json: items, include: :user
  end

  def show
    if params[:user_id] 
      user = User.find(params[:user_id])
      items = user.items.find(params[:id])
    else
      items = Item.find(params[:id])
    end
    render json: items
  end

  def create
    user = User.find(params[:user_id])
    items = user.items.create(item_params)
    render json: items, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response
    render json: { error: "404" }, status: :not_found
end

end

