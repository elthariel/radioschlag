class UsersController < ApplicationController
  filter_access_to [:edit, :update], :load_method => :current_user
  filter_access_to [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Votre compte a bien ete cree"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    params[:user][:role_ids] ||= []
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profil mis a jour"
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
end
