require 'minitest/autorun'
require 'minitest/pride'
require './lib/init'

class InitTest < Minitest::Test
  def setup
    @init = Init.new
  end
  
  def test_new_shuffled_deck


    deck = @init.new_shuffled_deck

    assert_instance_of Deck, deck
    assert_equal 52, deck.cards.length
    assert deck.cards.is_a?(Array)
    deck.cards.each do |card|
      assert card.is_a?(Card)
      assert card.suit.is_a?(Symbol)
      assert card.value.is_a?(String)
      assert card.rank.is_a?(Integer)
      
    end
  end

  def test_deal_cards
    decks = @init.deal_cards
    
    assert_instance_of Array, decks
    assert_instance_of Deck, decks[0]
    assert decks[0].cards.length == decks[1].cards.length
    assert_equal 26, decks[1].cards.length
  end
end