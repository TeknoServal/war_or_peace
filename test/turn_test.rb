# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'
require './lib/card'
require './lib/player'
require './lib/deck'

class TurnTest < Minitest::Test
  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)
    @card9 = Card.new(:diamond, '8', 8)

    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])

    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)

    @turn = Turn.new(@player1, @player2)
  end

  def test_exists
    assert_instance_of(Turn, @turn)
  end

  def test_players
    assert_equal @player1, @turn.player1
  end

  def test_type
    assert_equal :basic, @turn.type
  end

  def test_winner
    # Test case 1
    @winner = @turn.winner

    assert_equal @player1, @winner

    # Test case 2
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card4, @card3, @card6, @card7])

    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)

    @turn = Turn.new(@player1, @player2)

    @winner = @turn.winner

    assert_equal @player2, @winner

    # Test case 3
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card4, @card3, @card9, @card7])

    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)

    @turn = Turn.new(@player1, @player2)

    @winner = @turn.winner

    assert_equal 'No Winner', @winner
  end

  def test_pile_cards
    # Test case 1
    @turn.pile_cards

    assert_equal 3, @player1.deck.cards.length
    assert_equal 3, @player2.deck.cards.length

    assert_equal 2, @turn.spoils_length
    assert_equal [@card1, @card3], @turn.spoils_of_war

    # Test case 2
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card4, @card3, @card6, @card7])

    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)

    @turn = Turn.new(@player1, @player2)

    @turn.pile_cards

    assert_equal 6, @turn.spoils_length
    assert_equal 1, @player1.deck.cards.length
    assert_equal 1, @player2.deck.cards.length

    assert_equal [@card1, @card2, @card5, @card4, @card3, @card6], @turn.spoils_of_war

    # Test case 3
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card4, @card3, @card9, @card7])

    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)

    @turn = Turn.new(@player1, @player2)

    @turn.pile_cards

    assert_equal 6, @turn.spoils_length
    assert_equal 1, @player1.deck.cards.length
    assert_equal 1, @player2.deck.cards.length

    assert_equal [@card1, @card2, @card5, @card4, @card3, @card9], @turn.spoils_of_war
  end

  def test_award_spoils
    # Test case 1
    @winner = @turn.winner

    @turn.pile_cards

    @turn.award_spoils(@winner)

    assert_equal [@card2, @card5, @card8, @card1, @card3], @player1.deck.cards

    # Test case 2
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card4, @card3, @card6, @card7])

    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)

    @turn = Turn.new(@player1, @player2)

    @winner = @turn.winner

    assert_equal @player2, @winner

    # Test case 3
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card4, @card3, @card9, @card7])

    @player1 = Player.new('Megan', @deck1)
    @player2 = Player.new('Aurora', @deck2)

    @turn = Turn.new(@player1, @player2)

    @winner = @turn.winner

    @turn.pile_cards

    @turn.award_spoils(@winner)

    assert_equal [@card8], @player1.deck.cards
    assert_equal [@card7], @player2.deck.cards
  end
end
