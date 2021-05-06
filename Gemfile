source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Rails
gem 'rails', '~> 6.1.3.2'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 5.0.0'
gem 'turbo-rails'

gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.4.2', require: false
gem 'clearance'
gem 'jbuilder', '~> 2.7'
gem 'kt-paperclip'
gem 'pg'
gem 'redcarpet'
gem 'rollbar'
gem 'sendgrid-actionmailer'
gem 'trestle'
gem 'webpacker', git: 'https://github.com/rails/webpacker.git'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'letter_opener'
  gem 'listen', '~> 3.4'# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

