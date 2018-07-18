class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.page(params[:page]).per Settings.paginates_per
  end

  def show
    redirect_to(root_url) unless @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "user_mailer.account_activation.require"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t("users.edit.updated")
      redirect_to @user
    else
      flash[:danger] = t "users.edit.updatefa"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.edit.delco"
    else
      flash[:danger] = t "users.edit.delfa"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t("users.edit.danger")
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user?(@user)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "users.error"
    redirect_to root_url
  end
end
