source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.4"

# Rails framework
gem "rails", "~> 7.0.8", ">= 7.0.8.4"

# Puma web server para producción
gem "puma", "~> 5.0"

# Driver para conectar con Neo4j
gem 'neo4j-ruby-driver', '~> 4.4'


gem 'bigdecimal'


gem 'activemodel', '~> 7.0.8.4'

# HTTParty para manejo de requests HTTP
gem 'httparty'


gem 'dotenv-rails', groups: [:development, :test]

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
end


gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]


gem "bootsnap", require: false
