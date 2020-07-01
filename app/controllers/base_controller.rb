# frozen_string_literal: true

class BaseController
  def initialize(conn)
    @conn = conn
  end

  def response(command, *parameters)
    @conn.write(
      command: command,
      parameters: parameters
    )
  end

  def broadcast(command, *parameters)
    @conn.broadcast(
      command: command,
      parameters: parameters
    )
  end

  def current_player
    @conn.player
  end
end