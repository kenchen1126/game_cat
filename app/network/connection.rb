# frozen_string_literal: true

require 'json'

class Connection
  def initialize(socket)
    @socket = socket
    # TODO: Auto Detect Controller
    @controller = MapController.new(self)
  end

  def write(data)
    @socket.write(data.to_json)
  end

  def receive(data)
    data = JSON.parse(data)
    return unless @controller.respond_to?(data['command'])

    @controller.send(data['command'], *data['parameters'])
  end
end