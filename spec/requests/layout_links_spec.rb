require 'spec_helper'

describe "LayoutLinks | " do
    it "Home page at '/' | " do
      get '/'
      response.should have_selector('title', :content => "Home")
    end
    
    it "contact page at '/contact'" do
      get '/contact'
      response.should have_selector('title', :content => "Contact")
    end
    
    it "About page at '/about'" do
      get '/about'
      response.should have_selector('title', :content => "About")
    end

    it "Should havve the right links on the layout" do
        visit root_path
        click_link "About"
        response.should have_selector('title', :content => "About")
        click_link "Help"
        response.should have_selector('title', :content => "Help")
        click_link "Contact"
        response.should have_selector('title', :content => "Contact")
    end                

    describe "quando non loggato" do
      it "deve esserci il link signin" do 
        visit root_path
        response.should have_selector("a", :href => signin_path, 
                                           :content => "Sign in")
      end
    end

    describe "quando loggato | " do
      before(:each) do
        @user = Factory(:user)
        visit signin_path
        fill_in :email, :with => @user.email
        fill_in :password, :with => @user.password
        click_button
      end

      it "deve esserci il link signout" do 
        visit root_path
        response.should have_selector("a", :href => signout_path, 
                                           :content => "Sign out")
      end
      it "deve avere link al profilo" do
        visit root_path
        response.should have_selector("a", :href => user_path(@user), 
                                           :content => "Profile")
      end
    end
end
