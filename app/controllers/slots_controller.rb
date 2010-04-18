class SlotsController < ApplicationController
  filter_resource_access

  def index
    @slots = Slot.all(:order => 'start')
  end

  def show
    @slot = Slot.find(params[:id])
  end

  def new
    @slot = Slot.new
  end

  def create
    @slot = Slot.new(params[:slot])
    if @slot.save
      flash[:notice] = "Successfully created slot."
      redirect_to @slot
    else
      render :action => 'new'
    end
  end

  def edit
    @slot = Slot.find(params[:id])
  end

  def update
    @slot = Slot.find(params[:id])
    if @slot.update_attributes(params[:slot])
      flash[:notice] = "Successfully updated slot."
      redirect_to @slot
    else
      render :action => 'edit'
    end
  end

  def destroy
    @slot = Slot.find(params[:id])
    @slot.destroy
    flash[:notice] = "Successfully destroyed slot."
    redirect_to slots_url
  end
end
