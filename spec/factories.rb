Factory.define :user do |user|
  user.name                   "ska"
  user.email                  "ska@pippo.it"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Contenuto micropost"
  micropost.association :user
end

