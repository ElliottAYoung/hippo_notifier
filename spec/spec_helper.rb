require 'simplecov'
SimpleCov.start do
  add_filter do |source_file|
    source_file.filename.include?("spec")
  end

  add_group "Errors" do |src_file|
    src_file.filename.include?("/errors")
  end

  add_group "Services" do |src_file|
    src_file.filename.include?("/services")
  end

  add_group "Batches" do |src_file|
    src_file.filename.include?("/batches")
  end

  add_group "Base Files" do |src_file|
    !src_file.filename.include?("/errors") && !src_file.filename.include?("/services") && !src_file.filename.include?("/batches")
  end
end

SimpleCov.minimum_coverage_by_file 95

require "bundler/setup"
require "hippo_notifier"
require "pry"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
