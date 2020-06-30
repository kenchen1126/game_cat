# frozen_string_literal: true

module WebSocketServer
  
  UNSUPPORT_RESPONSE = [501, { 'Content-Type' => 'text/plain' }, ['Unsupport']].freeze

  def self.call(env)
    ws = Protocol::WebSocket.new(env)
    ws.response
  rescue Protocol::WebSocket::InvalidRequest
    UNSUPPORT_RESPONSE
  end
end