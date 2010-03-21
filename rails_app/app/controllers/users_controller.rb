class UsersController < ApplicationController
  filter_access_to [:edit, :update], :load_method => :current_user
  filter_access_to [:new, :create, :index]

  def index
    @users = User.find(:all)
  end

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
    if params[:id] == 'current' or !params[:id]
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

  def update
    params[:user][:role_ids] ||= []

    if params[:id] == 'current'
      @user = current_user
    elsif params[:id]
      @user = User.find(params[:id])
    end

    if params[:ftp] && params[:ftp][:create]
      create_ftp_account
    end
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profil mis a jour"
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end

  protected

  def create_ftp_account
    path = "#{RADIO_CONFIG[:ftp_root]}/#{@user.username}"
    `mkdir "#{path}"`
    ftp = FtpAccount.create(:user_id => @user.id,
                            :quota => RADIO_CONFIG[:ftp_default_quota],
                            :sessions => RADIO_CONFIG[:ftp_sessions])
    @user.ftp_account_id = ftp.id
    @user.save
  end
end
