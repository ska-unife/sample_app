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

end
