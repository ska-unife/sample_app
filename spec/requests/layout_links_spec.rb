require 'spec_helper'

describe "LayoutLinks" do
    it "Home page at '/'" do
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
end
