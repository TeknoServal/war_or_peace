# frozen_string_literal: true

# Holds a player and provides access to their deck
class Player
  attr_reader :deck, :name

  def initialize(name, deck)
    @deck = deck
    @name = name
  end

  def lost?
    deck.cards.length.zero?
  end
end
