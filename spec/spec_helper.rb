# encoding: utf-8
require 'mac-address'

module Rspec::FixtureLoader
  def fixture(scenario)
    File.open(File.expand_path("../fixtures/#{scenario}", __FILE__), &:read)
  end
end
