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
    return [@player1, @player2].max_by { |player| player.rank_of_card_at(0) } if type == :basic
    return [@player1, @player2].max_by { |player| player.rank_of_card_at(2) } if type == :war

    'No Winner'
  end

  def pile_cards
    case type
    when :basic
      @spoils_of_war += [player1.remove_card(1)]
      @spoils_of_war += [player2.remove_card(1)]
    when :war, :mutually_assured_destruction
      @spoils_of_war += player1.remove_card(3)
      @spoils_of_war += player2.remove_card(3)
    end
  end

  def award_spoils(winner)
    winner.add_card(@spoils_of_war) if type == :war || type == :basic
  end

  def spoils_length
    spoils_of_war.length
  end
end
