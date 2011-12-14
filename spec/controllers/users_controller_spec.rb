require 'spec_helper'

describe UsersController do
  render_views
  
  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
    end
    it "andato tutto bene" do
      get :show, :id => @user
      response.should be_success
    end
    it "trovato user giusto" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    it "Titolo corretto" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name )
    end
    it "Nome utente nella pagina" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name )
    end
    
    
  
  
  
  end
  
  describe "GET 'new'" do
    it "Pagina esistente" do
      get 'new'
      response.should be_success
    end
    it "Titolo pagina corretto" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end
  end
end
