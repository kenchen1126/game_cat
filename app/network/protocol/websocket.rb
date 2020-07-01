# frozen_string_literal: true

require 'json'

module Protocol
  class WebSocket
    class InvalidRequest < RuntimeError; end

    def initialize(env)
      @env = env
      @conn = Connection.new(self)
      setup
    end

    def websocket?
      Faye::WebSocket.websocket?(@env)
    end

    def response
      @ws.rack_response
    end

    def write(data)
      @ws.send(data)
    end

    private

    def receive(event)
      @conn.receive(event.data)
    end

    def setup
      raise InvalidRequest unless websocket?

      @ws = Faye::WebSocket.new(@env)
      @ws.on :open, @conn.method(:open)
      @ws.on :message, method(:receive)
      @ws.on :close, @conn.method(:close)
    end
  end
end