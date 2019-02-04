class UsersController < ApplicationController
  before_action :set_search_val, only: [:show, :edit]
  def show
  end

  def edit
    render "users/#{params[:name]}", locals: {user: current_user }
  end

  private
  def set_search_val
    @q = Item.ransack(params[:q])
    @categories = Category.all
    @items = @q.result.includes(:category, :brand).page(params[:page]).per(48)
    @count = @items.total_count
  end
end
