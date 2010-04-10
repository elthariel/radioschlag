require File.dirname(__FILE__) + '/../spec_helper'
 
describe AudioFilesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => AudioFile.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    AudioFile.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    AudioFile.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(audio_file_url(assigns[:audio_file]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => AudioFile.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    AudioFile.any_instance.stubs(:valid?).returns(false)
    put :update, :id => AudioFile.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    AudioFile.any_instance.stubs(:valid?).returns(true)
    put :update, :id => AudioFile.first
    response.should redirect_to(audio_file_url(assigns[:audio_file]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    audio_file = AudioFile.first
    delete :destroy, :id => audio_file
    response.should redirect_to(audio_files_url)
    AudioFile.exists?(audio_file.id).should be_false
  end
end
