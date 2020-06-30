# frozen_string_literal: true

class MapController
  def initialize(conn)
    @conn = conn
  end

  def move(x, y)
    @conn.write(command: 'move', parameters: [x, y])
  end
end