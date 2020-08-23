# frozen_string_literal: true

# Holds and manages the turn
class Turn
  attr_reader :player1, :player2, :spoils_of_war, :type, :winner

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []

    @type = determine_type
    @winner = determine_winner
  end

  def determine_type
    return :basic unless player1.rank_of_card_at(0) == player2.rank_of_card_at(0)
    return :loss if player1.card_count < 3 || player2.card_count < 3
    return :war unless player1.rank_of_card_at(2) == player2.rank_of_card_at(2)

    :mutually_assured_destruction
  end

  def determine_winner
    case type
    when :basic
      return player1 unless player1.rank_of_card_at(0) < player2.rank_of_card_at(0)

      player2
    when :war
      return player1 unless player1.rank_of_card_at(2) < player2.rank_of_card_at(2)

      player2
    when :mutually_assured_destruction
      'No Winner'
    end
  end

  def pile_cards
    case type
    when :basic
      spoils_of_war << player1.remove_card
      spoils_of_war << player2.remove_card
    when :war
      3.times do
        spoils_of_war << player1.remove_card
        spoils_of_war << player2.remove_card
      end
    when :mutually_assured_destruction
      3.times do
        spoils_of_war << player1.remove_card
        spoils_of_war << player2.remove_card
      end
    end
  end

  def award_spoils(winner)
    spoils_of_war.each { |card| winner.add_card(card) } unless type == :mutually_assured_destruction || type == :loss
  end

  def spoils_length
    spoils_of_war.length
  end
end
