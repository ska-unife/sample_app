require 'faker'

namespace :db do
  desc "Riempio database con dati esempio"

  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_admin_user
    make_users
    make_microposts
    make_relationships
  end
end


def make_admin_user
  admin = User.create!(:name => "Ska",
                     :email => "test@ilpescecane.it",
                     :password => "sicura",
                     :password_confirmation => "sicura")
  admin.toggle!(:admin)
end

def make_users
  99.times do |n|
    name = Faker::Name.name
    email = "test-#{n+1}@ilpescecane.it"
    password = "password"
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_microposts
  User.all(:limit => 10).each do |user|
    10.times do
      user.microposts.create!(:content => Faker::Lorem.sentence(5))
    end
  end
end


def make_relationships
  users = User.all
  user = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end












