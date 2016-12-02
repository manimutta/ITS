class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index,:edit_user]
  before_action :check_admin, only: [:index,:edit_user]
  before_action :set_user, only: [:show, :edit, :edit_user, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1/edit
  def edit_user
    @roles = Role.all
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user.roles.destroy
    params[:roles].each do |role|
      RoleUser.create(user_id: @user.id, role_id: role)
    end
    @user.status = params[:status]
    @user.save
    redirect_to users_url, notice: 'User was successfully updated.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end
    def check_admin
      if !current_user.has_role("Admin")
        redirect_to new_user_session_path
      end
    end
end
