#!/usr/bin/env bash
# exit on error
set -o errexit

# Force Ruby platform for Nokogiri and other gems
bundle config set build.nokogiri --use-system-libraries=false

# Install dependencies
bundle install

# Precompile assets
bundle exec rails assets:precompile

# Clean assets
bundle exec rails assets:clean

# Run database migrations
bundle exec rake db:migrate

# Seed the database
bundle exec rails db:seed
