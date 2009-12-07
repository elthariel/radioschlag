class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
  end
  
  def show
    @playlist = Playlist.find(params[:id])
  end
  
  def new
    @playlist = Playlist.new
  end
  
  def create
    @playlist = Playlist.new(params[:playlist])
    if @playlist.save
      flash[:notice] = "Successfully created playlist."
      redirect_to @playlist
    else
      render :action => 'new'
    end
  end
  
  def edit
    @playlist = Playlist.find(params[:id])
  end
  
  def update
    @playlist = Playlist.find(params[:id])
    if @playlist.update_attributes(params[:playlist])
      flash[:notice] = "Successfully updated playlist."
      redirect_to @playlist
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy
    flash[:notice] = "Successfully destroyed playlist."
    redirect_to playlists_url
  end
end
