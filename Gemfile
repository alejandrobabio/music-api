# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'activerecord', require: 'active_record'
gem 'pg'
gem 'rake'
gem 'rack-ssl-enforcer'
gem 'racksh', require: false
gem 'puma'
gem 'shrine', '~> 2.0'
gem 'image_processing', '~> 1.0'
gem 'sucker_punch', '~> 2.0'

group :development, :test do
  gem 'rspec'
  gem 'awesome_print'
  gem 'pry-byebug'
end

group :development do
  gem 'rerun'
end

group :test do
  gem 'rack-test', require: false
  gem 'database_cleaner', require: false
  gem 'factory_bot', require: false
  gem 'shoulda-matchers', require: false
  # TODO: Evaluate faker gem, it's big and it slows tests
  gem 'faker', require: false
end

