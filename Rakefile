# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
Rails.application.load_tasks

if Bundler::Audit::Task.is_a?(Class)
  require 'bundler/audit/task'
  Bundler::Audit::Task.new
end
