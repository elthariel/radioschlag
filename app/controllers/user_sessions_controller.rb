class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Vous etes connectes"
          redirect_to root_url
        end
        format.json {render :nothing => true, :status => 200}
      end
    else
      respond_to do |format|
        format.html do
          flash[:notice] = "Login et/ou Password incorrect(s)"
          redirect_to login_url
        end
        format.json {render :nothing => true, :status => 503}
      end
    end
  end

  def destroy
    @user_session = UserSession.find()
    @user_session.destroy
    flash[:notice] = "Vous etes maintenant deconnecte."
    redirect_to root_url
  end
end
