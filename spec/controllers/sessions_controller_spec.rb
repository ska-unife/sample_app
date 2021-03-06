require 'spec_helper'

describe SessionsController do
  render_views  

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do 
    describe "Signin non valido" do
      before(:each) do
        @attr = { :email => "user@user.it", 
                  :password => "sbagliata" }
      end
      
      it "Re-render della pagina di login" do
        post :create, :session => @attr
        response.should render_template('new')      
      end
      it "Titolo" do
        post :create, :session => @attr
        response.should have_selector("title", :content => "Sign in")        
      end
      it "Flash message di errore" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid /i
      end
    end

    describe "Signin valido" do
      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, 
                  :password => @user.password }
      end
      
      it "controllo avvenuto signin" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should redirect_to(user_path(@user))
      end

      it "Redirect ad avvenuto signin" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))        
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "Signout di un user" do
      test_sign_in(Factory(:user))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end

end
