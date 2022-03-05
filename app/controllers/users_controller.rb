class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # Debugger will open a debugger byebug console panel in the IDE
    # debugger
  end

  private
end
