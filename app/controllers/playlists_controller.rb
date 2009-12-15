class PlaylistsController < ApplicationController
#  filter_access_to :add_file, :attribute_check => true, :load_method => lambda {}
#  filter_resource_access :load_method => :load_plasdaylist
  filter_access_to :index, :show, :new, :create, :edit, :update, :destroy
  filter_access_to :add_file, :sort, :remove_file, :load_method => :load_for_ajax

  def index
    @playlists = Playlist.all()
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
      render :nothing => true, :status => 403
    elsif @playlist.audio_file_assignments.exists?(:audio_file_id => file.id)
      render :nothing => true, :status => 403
    else
      @playlist.audio_files << file
      render :nothing => true
    end
  end

  def remove_file
    @playlist = Playlist.find(params[:playlist_id])
    assignment = @playlist.audio_file_assignments.find_by_audio_file_id(params[:id].sub('audio_file_',''))
    if assignment
      assignment.delete
      render :update do |page|
        page.remove "audio_file_#{assignment.audio_file_id}"
      end
    else
      render :nothing => true
    end
  end

  def sort
    @playlist = Playlist.find(params[:playlist_id])

    # FIXME too many sql requests !
    params[:audio_files_list].each_with_index do |file_id, pos|
      f = @playlist.audio_file_assignments.find_by_audio_file_id(file_id)
      f.position = pos + 1
      f.save
    end

#     assignments = params[:audio_files_list].map do |file_id|
#       @playlist.audio_file_assignments.find_by_audio_file_id(file_id)
#     end
#     @playlist.audio_file_assignments = assignments

    render :nothing => true
  end

  protected

  def load_for_ajax
#    puts Playlist.find(params[:playlist_id])
    puts "\n\n Ceci est un test \n\n"
    @playlist = Playlist.find(params[:playlist_id])
  end
end
