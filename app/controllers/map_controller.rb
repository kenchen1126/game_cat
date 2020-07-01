# frozen_string_literal: true

class MapController < BaseController

  def join
    boardcast(:join, current_player.id)
  end

  def move(x, y)
    boardcast(:move, current_player.id, x, y)
  end
end