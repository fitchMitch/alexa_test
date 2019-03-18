source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Technical
# -----------------------
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '2.5.3'

gem 'sinatra'
gem 'ralyxa'

gem 'byebug',                                               '~> 10.0'
gem 'better_errors',                                        '~> 2.4'
gem 'binding_of_caller',                                    '~> 0.8'

gem 'rspec'

group :test do
  gem 'rack-test'
  gem 'rspec'
end
