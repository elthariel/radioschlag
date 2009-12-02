require File.dirname(__FILE__) + '/../spec_helper'
 
describe AudioFileStylesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => AudioFileStyle.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    AudioFileStyle.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    AudioFileStyle.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(audio_file_style_url(assigns[:audio_file_style]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => AudioFileStyle.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    AudioFileStyle.any_instance.stubs(:valid?).returns(false)
    put :update, :id => AudioFileStyle.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    AudioFileStyle.any_instance.stubs(:valid?).returns(true)
    put :update, :id => AudioFileStyle.first
    response.should redirect_to(audio_file_style_url(assigns[:audio_file_style]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    audio_file_style = AudioFileStyle.first
    delete :destroy, :id => audio_file_style
    response.should redirect_to(audio_file_styles_url)
    AudioFileStyle.exists?(audio_file_style.id).should be_false
  end
end
