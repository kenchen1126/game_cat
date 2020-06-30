# frozen_string_literal: true

require 'rubygems'
require 'bundler'
require 'singleton'
# 透過 Bundler 自動載入套件
Bundler.require
#require 'app/servers/websocket_server.rb'
require 'config/inflector' #加這行就可以拿掉require websocket_server
require 'app/network/protocol/websocket'

class SimpleRPG
  include Singleton

  class << self
    def run(server, options = {})
      # 呼叫實例上的方法
      instance.start(server, options)
    end

    def root
      @root ||= File.absolute_path('../..', __FILE__)
    end

  end

  def initialize
    prepare_loader
    prepare_reloading
    @loader.setup
  end

  def start(server, options = {})
    Thread.new { @fsevent.run }
    # TODO: Select Server
    Rack::Handler.default.run(WebSocketServer, options)
  end

  # TODO: 實作專門的 HTTP 處理程式
  def call(_env)
    # 簡單回傳 Hello World
    [200, { 'Content-Type' => 'text/plain' }, ['Hello World']]
  end
  
  def prepare_loader
    @loader = Zeitwerk::Loader.new
    @loader.inflector = Inflector.new
    @autoload_paths = Dir["#{self.class.root}/app/*"]
    @autoload_paths.each do |path|
      @loader.push_dir(path)
    end
  end

  private

  def prepare_reloading
    @loader.enable_reloading
    @fsevent = FSEvent.new
    @fsevent.watch @autoload_paths do |_path|
      @loader.reload
    end
  end
end