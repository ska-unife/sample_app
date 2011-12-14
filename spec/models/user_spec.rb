require 'spec_helper'

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

describe User do
  before(:each) do
    @attr = { 
      :name => "Example user", 
      :email => "example@ilpescecane.it",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "Crea nuovo utente" do
    User.create!(@attr)
  end

  it "Nome necessario" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "E-mail necessaria" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
    
  it "Errore nome troppo lungo" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end    

  it "Mail accettata" do
    addresses = %w[info@ilpescecane.it pluto@gmail.com cane@cucia.org]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
    
  it "Mail non accettata" do
    addresses = %w[info_at_ilpescecane.it pluto@gmail,com cane@cucia.org.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
    
  it "Mail deve essere unica, no duplicazioni" do
    User.create!(@attr)
    user_with_duplicate_mail = User.new(@attr)
    user_with_duplicate_mail.should_not be_valid 
  end
    
  it "Mail deve essere unica, no duplicazioni, e case insensitive pippo@pc.it = PIPPo@pC.It" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_mail = User.new(@attr)
    user_with_duplicate_mail.should_not be_valid 
  end


  describe "passwords" do
    before(:each) do
      @user = User.new(@attr)
    end     
    
    it "Manca attributo password" do
      @user.should respond_to(:password)
    end
    
    it "Manca attributo password_confirmation" do
      @user.should respond_to(:password_confirmation)
    end
  end
  
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
          
    it "Manca attributo encripted password" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "Manca password criptata" do
      @user.encrypted_password.should_not be_blank
    end
  end

  describe "Validazione password" do
    it "Password vuota" do
      no_password_user = User.new(@attr.merge(:password => "", :password_confirmation => ""))
      no_password_user.should_not be_valid
    end
  
    it "Password e conferma non uguali" do
      no_password_valid = User.new(@attr.merge( :password_confirmation => "invalid"))
      no_password_valid.should_not be_valid
    end
    
    it "Password troppo corta" do
      short = "a" * 5
      short_password = User.new(@attr.merge( :password => short, :password_confirmation => short ))
      short_password.should_not be_valid
    end
  
    it "Password troppo lunga" do
      long = "a" * 41
      long_password = User.new(@attr.merge( :password => long, :password_confirmation => long ))
      long_password.should_not be_valid
    end
  
  end
end

