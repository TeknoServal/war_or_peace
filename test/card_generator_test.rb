# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/card_generator'
require './lib/card'

class CardGeneratorTest < Minitest::Test
  def test_exists
    generator = CardGenerator.new

    assert_instance_of CardGenerator, generator
  end

  def test_are_cards
    cards = CardGenerator.new.generate_cards('./test/test_cards.txt')

    cards.each { |card| assert_instance_of Card, card }
  end

  def test_cards
    test_cards =
      [
        Card.new(:heart, '2', 2),
        Card.new(:heart, '3', 3),
        Card.new(:heart, '4', 4),
        Card.new(:heart, '5', 5)
      ]

    assert_equal test_cards, CardGenerator.new.generate_cards('./test/test_cards.txt')
  end
end
