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

  def rank_of_card_at(index)
    deck.rank_of_card_at(index)
  end

  def card_count
    deck.length
  end

  def remove_card(num)
    deck.remove_card(num)
  end

  def add_card(card)
    deck.add_card(card)
  end
end
