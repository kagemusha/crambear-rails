class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end
  
  def show
    get_user(params)
  end


  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully created user."
      redirect_to @user
    else
      render :action => 'new'
    end
  end
  
  def edit
    get_user(params)
  end
  
  def update
    get_user(params)
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end

  private

  def get_user(params)
    @user = (current_user.admin? and params[:id])  ? User.find(params[:id]) : current_user
  end
end
