require File.dirname(__FILE__) + '/../spec_helper'
 
describe IncomingAudioFilesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    IncomingAudioFile.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    IncomingAudioFile.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(incoming_audio_files_url)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    incoming_audio_file = IncomingAudioFile.first
    delete :destroy, :id => incoming_audio_file
    response.should redirect_to(incoming_audio_files_url)
    IncomingAudioFile.exists?(incoming_audio_file.id).should be_false
  end
end
