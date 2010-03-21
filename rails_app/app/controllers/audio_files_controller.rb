class AudioFilesController < ApplicationController
  filter_resource_access

  def index
    @audio_files = AudioFile.all
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
