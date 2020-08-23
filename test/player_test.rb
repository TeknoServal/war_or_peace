# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'

class PlayerTest < Minitest::Test
  def test_it_exists
    card1 = Card.new(:spade, 'Ten', 10)
    card2 = Card.new(:heart, 'Three', 3)
    card3 = Card.new(:club, 'Jack', 11)
    cards = []
    cards << card1
    cards << card2
    cards << card3
    deck = Deck.new(cards)

    player = Player.new('Charles', deck)

    assert_instance_of(Player, player)
  end

  def test_loss_condition
    card1 = Card.new(:spade, 'Ten', 10)
    card2 = Card.new(:heart, 'Three', 3)
    card3 = Card.new(:club, 'Jack', 11)
    cards = []
    cards << card1
    cards << card2
    cards << card3
    deck = Deck.new(cards)

    player = Player.new('Charles', deck)

    assert_equal(false, player.lost?)

    player.deck.remove_card(1)
    assert_equal(false, player.lost?)
    player.deck.remove_card(1)
    assert_equal(false, player.lost?)
    player.deck.remove_card(1)

    assert_equal(true, player.lost?)
    assert_equal(0, player.deck.cards.length)
  end

  def test_name
    card1 = Card.new(:spade, 'Ten', 10)
    card2 = Card.new(:heart, 'Three', 3)
    card3 = Card.new(:club, 'Jack', 11)
    cards = []
    cards << card1
    cards << card2
    cards << card3
    deck = Deck.new(cards)

    player = Player.new('Charles', deck)

    assert_equal('Charles', player.name)
  end

  def test_rank_of_card_at
    card1 = Card.new(:spade, 'Ten', 10)
    card2 = Card.new(:heart, 'Three', 3)
    card3 = Card.new(:club, 'Jack', 11)
    cards = []
    cards << card1
    cards << card2
    cards << card3
    deck = Deck.new(cards)

    player = Player.new('Charles', deck)

    assert_equal 11, player.rank_of_card_at(2)
    assert_equal 3, player.rank_of_card_at(1)
  end

  def test_card_count
    card1 = Card.new(:spade, 'Ten', 10)
    card2 = Card.new(:heart, 'Three', 3)
    card3 = Card.new(:club, 'Jack', 11)
    cards = []
    cards << card1
    cards << card2
    cards << card3
    deck = Deck.new(cards)

    player = Player.new('Charles', deck)

    assert_equal 3, player.card_count
  end

  def test_remove_card
    card1 = Card.new(:spade, 'Ten', 10)
    card2 = Card.new(:heart, 'Three', 3)
    card3 = Card.new(:club, 'Jack', 11)
    cards = []
    cards << card1
    cards << card2
    cards << card3
    deck = Deck.new(cards)

    player = Player.new('Charles', deck)

    assert_equal card1, player.remove_card(1)
    assert_equal 2, player.card_count
  end

  def test_add_card
    card1 = Card.new(:spade, 'Ten', 10)
    card2 = Card.new(:heart, 'Three', 3)
    card3 = Card.new(:club, 'Jack', 11)
    card4 = Card.new(:diamond, '8', 8)
    cards = []
    cards << card1
    cards << card2
    cards << card3
    deck = Deck.new(cards)

    player = Player.new('Charles', deck)

    player.add_card(card4)
  end
end
