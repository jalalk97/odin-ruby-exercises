# frozen_string_literal: true

require_relative "./lib/connect_four"

def main
  game = ConnectFour::Game.new
  game.play
end

main
