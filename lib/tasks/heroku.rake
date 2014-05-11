namespace :heroku do
  task :setup do
    `heroku create`
    `heroku run rake db:migrate db:seed`
  end
end
