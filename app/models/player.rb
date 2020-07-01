# frozen_string_literal: true

class Player
  attr_accessor :id

  def initialize(attributes = {})
    attributes.each do |name, value|
      instance_variable_set(:"@#{name}", value)
    end
  end
end