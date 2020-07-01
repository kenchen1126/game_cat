# frozen_string_literal: true

require 'json'

class Connection
  class << self
    def pool
      @pool ||= ConnectPool.new
    end

    def players
      pool.map(&:player)
    end
  end
  
  attr_reader :player

  def open(_event)
    next_id = Connection.players.max_by(&:id)&.id.to_i + 1
    @player = Player.new(id: next_id)
    
    Connection.pool.add(self)
  end

  def close(_event)
    Connection.pool.remove(self)
  end

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

  def boardcast(data)
    Connection.pool.each do |conn|
      conn.write(data)
    end
  end
end