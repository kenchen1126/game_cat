# frozen_string_literal: true

require 'rubygems'
require 'bundler'
require 'singleton'

# 透過 Bundler 自動載入套件
Bundler.require

class SimpleRPG
  include Singleton

  class << self
    def run(server, options = {})
      puts "You are starting #{server.capitalize} server with #{options}"
    end
  end
end