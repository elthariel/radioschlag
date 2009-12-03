class IncomingAudioFilesController < ApplicationController
  def index
    @incoming_audio_files = IncomingAudioFile.all
  end
  
  def new
    @incoming_audio_file = IncomingAudioFile.new
  end
  
  def create
    @incoming_audio_file = IncomingAudioFile.new(params[:incoming_audio_file])
    if @incoming_audio_file.save
      flash[:notice] = "Successfully created incoming audio file."
      redirect_to incoming_audio_files_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @incoming_audio_file = IncomingAudioFile.find(params[:id])
    @incoming_audio_file.destroy
    flash[:notice] = "Successfully destroyed incoming audio file."
    redirect_to incoming_audio_files_url
  end
end
