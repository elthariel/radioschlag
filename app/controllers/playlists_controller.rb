class PlaylistsController < ApplicationController
#  filter_access_to :add_file, :attribute_check => true, :load_method => lambda {}
#  filter_resource_access :load_method => :load_plasdaylist
  filter_access_to :index, :show, :new, :create, :edit, :update, :destroy
  filter_access_to :add_file, :load_method => :load_for_add_file

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

  def add_file
    @playlist = Playlist.find(params[:playlist_id])
    file = AudioFile.find(params[:id].sub('audio_file_',''))
    if (!file)
      render :text => 'nok', :status => 403
    end

    @playlist.audio_files << file

    puts file
    puts @playlist
    render :text => 'ok'
  end

  protected

  def load_for_add_file
#    puts Playlist.find(params[:playlist_id])
    puts "\n\n Ceci est un test \n\n"
    Playlist.find(params[:playlist_id])
  end

end
