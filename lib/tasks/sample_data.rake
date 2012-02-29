require 'faker'

namespace :db do
  desc "Riempio database con dati esempio"

  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Ska",
                 :email => "test@ilpescecane.it",
                 :password => "sicura",
                 :password_confirmation => "sicura")
    admin.toggle!(:admin)

    99.times do |n|
      name = Faker::Name.name
      email = "test-#{n+1}@ilpescecane.it"
      password = "password"
      User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
    end

    User.all(:limit => 10).each do |user|
      10.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end

  end
end 

