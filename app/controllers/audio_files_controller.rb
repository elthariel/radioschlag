class AudioFilesController < ApplicationController
  filter_resource_access
  filter_access_to :mass_update

  def index

    cond = index_conditions(params)

    respond_to do |format|
      format.html do
        # @posts = Post.paginate_by_board_id @board.id, :page => params[:page], :order => 'updated_at DESC'
        @audio_files = AudioFile.paginate :page => params[:page], :order => 'audio_file_style_id, audio_file_type_id, user_id, path', :conditions => cond
        render :action => 'index'
      end
      format.json do
        @audio_files = AudioFile.all
        render :json => @audio_files
      end
    end
  end

  def edit
    @audio_file = AudioFile.find(params[:id])
  end

  def update
    @audio_file = AudioFile.find(params[:id])
    if @audio_file.update_attributes(params[:audio_file])
      flash[:notice] = "Fichier mis a jour"
      redirect_to audio_files_url
    else
      render :action => 'edit'
    end
  end

  def mass_update
    cond = index_conditions(params)

    AudioFile.update_all(cond, :id => params[:audio_files_ids])

    redirect_to audio_files_url
  end

  def destroy
    @audio_file = AudioFile.find(params[:id])
    if File.writable?(@audio_file.path)
      #FIXME security
      `rm "#{@audio_file.path}"`
      @audio_file.destroy
      flash[:notice] = "Fichier supprime"
    else
      flash[:error] = "Impossible de supprimer le fichier"
    end
    redirect_to audio_files_url
  end

  def show
    @audio_file = AudioFile.find(params[:id])

    # FIXME hardwired path ... :(
    if @audio_file.in_ftp?
      path = @audio_file.path.gsub(RADIO_CONFIG[:ftp_root], RADIO_CONFIG[:ftp_root_pub])
    elsif @audio_file.in_audio?
      path = @audio_file.path.gsub(RADIO_CONFIG[:audio_root], RADIO_CONFIG[:audio_root_pub])
    else
      render :nothing => true, :status => 404
      return
    end

    options = {}
    options[:length] = File.size @audio_file.path
    options[:filename] = File.basename @audio_file.path   
    response.headers['X-Accel-Redirect'] = path
    send_file_headers! options

    render :nothing => true
  end

  protected
  def index_conditions(params)
    cond = {}

    # Owner condition
    if params[:user] and params[:user][:username] and !params[:user][:username].empty?
      puts "\n\n\n\n\n\n\n#{params[:user]} #{current_user.id}\n\n\n\n\n\n\n\n"
      if params[:user][:username] == 'me' and current_user
        cond[:user_id] = current_user.id
      else
        id = User.first(:conditions => {:username => params[:user][:username]}).id
        cond[:user_id] = id if id
      end
    end

    # Type and Style conditions
    cond[:audio_file_type_id] = params[:audio_file_type][:id] if params[:audio_file_type] and params[:audio_file_type][:id] and !params[:audio_file_type][:id].empty?
    cond[:audio_file_style_id] = params[:audio_file_style][:id] if params[:audio_file_type] and params[:audio_file_style][:id] and !params[:audio_file_style][:id].empty?

    # Return the built conditions
    cond
  end

end
