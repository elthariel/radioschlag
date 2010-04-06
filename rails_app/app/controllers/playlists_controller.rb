class PlaylistsController < ApplicationController
#  filter_access_to :add_file, :attribute_check => true, :load_method => lambda {}
#  filter_resource_access :load_method => :load_plasdaylist
  filter_access_to :index
  filter_access_to :show, :new, :create, :edit, :update, :destroy, :add_style, :remove_style, :update_style_metric, :attribute_check => true
  filter_access_to :add_file, :sort_file, :remove_file, :load_method => :load_for_ajax

  def index
    @playlists = Playlist.all()
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def new
    @playlist = Playlist.new
    @playlist.user_id = current_user.id
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

  def sort_file
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

  def add_style
    @playlist = Playlist.find(params[:id])
    if (@playlist.type_style_assignments.exists?(:audio_file_style_id => params[:style_id], :audio_file_type_id => params[:type_id]) or !AudioFileType.exists?(params[:type_id]) or !AudioFileStyle.exists?(params[:style_id]))
      render :nothing => true, :status => 403
    else
      @a = TypeStyleAssignment.new(:audio_file_type_id => params[:type_id],
                                  :audio_file_style_id => params[:style_id])
      @a.save
      @playlist.type_style_assignments << @a
      render :update do |page|
        page.insert_html 'bottom', 'type_style_list', :partial => 'type_style_list_item'
      end
    end
  end

  def remove_style
    @playlist = Playlist.find(params[:id])
    if (@playlist.type_style_assignments.exists?(params[:type_style_id]))
      @playlist.type_style_assignments.find(params[:type_style_id]).delete
      render :update do |page|
        page.remove "type_style_#{params[:type_style_id]}"
      end
    else
      render :nothing =>true, :status => 403
    end
  end

  def update_style_metric
    @playlist = Playlist.find(params[:id])
    if (@playlist.type_style_assignments.exists?(params[:type_style_id]))
      a = @playlist.type_style_assignments.find(params[:type_style_id])
      a.metric = params[:m]
      a.save
      render :nothing => true
    else
    render :nothing => true, :status => 403
    end
  end

  protected

  # FIXME This is ugly, fix view to have params[:id] instead
  def load_for_ajax
    @playlist = Playlist.find(params[:playlist_id])
  end
end
