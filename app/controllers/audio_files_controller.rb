class AudioFilesController < ApplicationController
  def index
    @audio_files = AudioFile.all
  end
  
  def show
    @audio_file = AudioFile.find(params[:id])
  end
  
  def new
    @audio_file = AudioFile.new
  end
  
  def create
    @audio_file = AudioFile.new(params[:audio_file])
    if @audio_file.save
      flash[:notice] = "Successfully created audio file."
      redirect_to @audio_file
    else
      render :action => 'new'
    end
  end
  
  def edit
    @audio_file = AudioFile.find(params[:id])
  end
  
  def update
    @audio_file = AudioFile.find(params[:id])
    if @audio_file.update_attributes(params[:audio_file])
      flash[:notice] = "Successfully updated audio file."
      redirect_to @audio_file
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @audio_file = AudioFile.find(params[:id])
    @audio_file.destroy
    flash[:notice] = "Successfully destroyed audio file."
    redirect_to audio_files_url
  end
end
