# frozen_string_literal: true

# Holds a deck of cards and methods to manage it
class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(index)
    cards[index].rank
  end

  def high_ranking_cards
    high_cards = []

    cards.each do |card|
      high_cards << card if card.rank >= 11
    end

    high_cards
  end

  def percent_high_ranking
    high_ranking_cards.length * 100 / cards.length
  end

  def remove_card(num)
    num > 1 ? cards.shift(num) : cards.shift
  end

  def add_card(new_cards)
    @cards += [new_cards].flatten
  end

  def length
    cards.length
  end
end
