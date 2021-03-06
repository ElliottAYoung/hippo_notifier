# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hippo_notifier/version"

Gem::Specification.new do |spec|
  spec.name          = "hippo_notifier"
  spec.version       = HippoNotifier::VERSION
  spec.authors       = ["ElliottAYoung"]
  spec.email         = ["elliott.a.young@gmail.com"]

  spec.summary       = "A Gem for handling mutli-channel notification processing & batching"
  spec.description   = "A Gem for handling mutli-channel notification processing & batching"
  spec.homepage      = "https://github.com/vsaportas/hippo_notifier"
  spec.license       = "MIT"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rb-readline"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "simplecov", '~> 0.15'

  spec.add_dependency "twilio-ruby", "~> 4.11.1"
  spec.add_dependency "pusher"
  spec.add_dependency "delayed_job_active_record", "~> 4.1.2"
  spec.add_dependency "activesupport", "~> 4.2.9"
  spec.add_dependency "bitly", "~> 1.1"
end
