class AudioFileStylesController < ApplicationController
  def index
    @audio_file_styles = AudioFileStyle.all
  end
  
  def show
    @audio_file_style = AudioFileStyle.find(params[:id])
  end
  
  def new
    @audio_file_style = AudioFileStyle.new
  end
  
  def create
    @audio_file_style = AudioFileStyle.new(params[:audio_file_style])
    if @audio_file_style.save
      flash[:notice] = "Successfully created audio file style."
      redirect_to @audio_file_style
    else
      render :action => 'new'
    end
  end
  
  def edit
    @audio_file_style = AudioFileStyle.find(params[:id])
  end
  
  def update
    @audio_file_style = AudioFileStyle.find(params[:id])
    if @audio_file_style.update_attributes(params[:audio_file_style])
      flash[:notice] = "Successfully updated audio file style."
      redirect_to @audio_file_style
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @audio_file_style = AudioFileStyle.find(params[:id])
    @audio_file_style.destroy
    flash[:notice] = "Successfully destroyed audio file style."
    redirect_to audio_file_styles_url
  end
end
