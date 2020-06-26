# frozen_string_literal: true

module WebSocketServer
  UNSUPPORT_RESPONSE = [501, { 'Content-Type' => 'text/plain' }, ['Unsupport']].freeze

  def self.call(env)
    return UNSUPPORT_RESPONSE unless Faye::WebSocket.websocket?(env)

    ws = Faye::WebSocket.new(env)
    ws.rack_response
  end
end