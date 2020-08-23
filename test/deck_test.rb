# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'

class DeckTest < Minitest::Test
  def test_it_exists
    card = Card.new(:spade, 'Ten', 10)
    cards = []
    cards << card
    deck = Deck.new(cards)

    assert_instance_of(Deck, deck)
  end

  def test_cards
    card = Card.new(:spade, 'Ten', 10)
    cards = []
    cards << card
    deck = Deck.new(cards)

    assert_equal(cards, deck.cards)
    assert_equal(card, deck.cards[0])
  end

  def test_high_ranking_methods
    card1 = Card.new(:spade, 'Ten', 10)
    card2 = Card.new(:heart, 'Three', 3)
    card3 = Card.new(:club, 'Jack', 11)
    cards = []
    cards << card1
    cards << card2
    cards << card3
    deck = Deck.new(cards)

    assert_equal(card3, deck.high_ranking_cards[0])
    assert_equal(33, deck.percent_high_ranking)
  end

  def test_add_remove
    deck = Deck.new([])
    card1 = Card.new(:spade, 'Ten', 10)
    card2 = Card.new(:heart, 'Three', 3)

    deck.add_card(card1)

    assert_equal(card1, deck.cards[0])

    deck.add_card(card2)

    assert_equal(card1, deck.cards[0])

    deck.remove_card

    assert_equal(card2, deck.cards[0])
  end

  def test_length
    card = Card.new(:spade, 'Ten', 10)
    cards = []
    cards << card
    deck = Deck.new(cards)
    assert_equal 1, deck.cards.length
    deck.add_card(Card.new(:spade, 'Jack', 11))
    assert_equal 2, deck.cards.length
  end
end
