class UserController < ApplicationController
  def edit 
    @user = User.first
  end
  
  def show 
    @user = User.first
  end
end
