# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.4.3'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.6'
gem 'sass-rails', '~> 5.0'
gem 'sqlite3'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', '~> 0.63.1'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# responsive gems
gem 'actionpack-action_caching'
gem 'actionpack-page_caching'
gem 'bcrypt'
gem 'carrierwave', '0.11.2'
gem 'fog'
gem 'httparty'
gem 'mini_magick'
gem 'rails_12factor'
gem 'twilio-ruby'
# gem 'cf'
gem 'net-telnet'

# Recommended update for CVE-2018-1000544 and CVE-2017-5946
gem 'rubyzip', '>= 1.2.2'
