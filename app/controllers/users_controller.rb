class UsersController < ApplicationController
  before_action :set_search_val, only: [:show]
  def show
  end

  private
  def set_search_val
    @q = Item.ransack(params[:q])
    @categories = Category.all
    @items = @q.result.includes(:category, :brand).page(params[:page]).per(48)
    @count = @items.total_count

  def edit
    render "users/#{params[:name]}", locals: {user: current_user }
  end
end
