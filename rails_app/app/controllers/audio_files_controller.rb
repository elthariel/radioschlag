class AudioFilesController < ApplicationController
  filter_resource_access

  def index

    respond_to do |format|
      format.html do
        # @posts = Post.paginate_by_board_id @board.id, :page => params[:page], :order => 'updated_at DESC'
        @audio_files = AudioFile.paginate :page => params[:page], :order => 'user_id'
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
end
