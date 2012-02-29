require 'spec_helper'

describe Micropost do
  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "testo contenuto" }
  end

  it "creazione nuova istanza micropost" do
    @user.microposts.create!(@attr)
  end
  
  describe "associazione utente | " do
    before(:each) do
      @micropost = @user.microposts.create(@attr)
    end    
    
    it "deve avere un attributo user" do
      @micropost.should respond_to(:user)
    end
    
    it "deve esserci la giusta associazione" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end
  end

  describe "validazioni" do
    it "richiesto user id" do
      Micropost.new(@attr).should_not be_valid
    end

    it "contenoto non puo' essere vuoto" do
      @user.microposts.build(:content => " ").should_not be_valid
    end
    
    it "contenuto troppo lungo" do
      @user.microposts.build(:content => "a" * 141 ).should_not be_valid
    end

  end
end

