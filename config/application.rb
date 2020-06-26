# frozen_string_literal: true

require 'rubygems'
require 'bundler'
require 'singleton'

require 'app/servers/websocket_server.rb'
# 透過 Bundler 自動載入套件
Bundler.require

class SimpleRPG
  include Singleton

  class << self
    def run(server, options = {})
      # 呼叫實例上的方法
      instance.start(server, options)
    end
  end

  def start(server, options = {})
    # TODO: 要透過 Server 選擇負責處理的物件
    # 透過 Rack::Handler 預設值啟動伺服器
    Rack::Handler.default.run(WebSocketServer, options)
  end

  # TODO: 實作專門的 HTTP 處理程式
  def call(_env)
    # 簡單回傳 Hello World
    [200, { 'Content-Type' => 'text/plain' }, ['Hello World']]
  end
end