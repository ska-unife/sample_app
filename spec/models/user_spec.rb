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
        @attr = { :name => "Example user", :email => "example@ilpescecane.it"}
    end

    it "Crea nuovo utente" do
        User.create!(@attr)
    end

    it "Should require a name" do
        no_name_user = User.new(@attr.merge(:name => ""))
        no_name_user.should_not be_valid
    end

    it "Should require an email" do
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
 






end

