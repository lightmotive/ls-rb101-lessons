# frozen_string_literal: true

require_relative 'players'
require_relative '../../../ruby-common/messages'

def round_state_create(players, win_score)
  round_state = { win_score: win_score, scores: {} }

  players.each do |player|
    round_state[:scores][player_id(player)] = 0
  end

  round_state
end

def round_player_score(player, round_state)
  round_state[:scores][player_id(player)]
end

def round_player_score_increment(player, round_state)
  round_state[:scores][player_id(player)] += 1
end

# rubocop:disable Metrics/MethodLength
def round_win_score_prompt
  prompt_until_valid(
    "Games to win (default: 5)?",
    get_input: -> { gets.strip },
    convert_input: lambda do |input|
      return 5 if input.empty?
      input.to_i
    end,
    validate: lambda do |input|
      unless input.positive?
        raise ValidationError, "Please enter a number greater than 0 " \
                               "or hit enter to accept the default."
      end
    end
  )
end
# rubocop:enable Metrics/MethodLength

def round_winning_player(players, round_state)
  players.select do |player|
    round_player_score(player, round_state) == round_state[:win_score]
  end.first
end

def players_by_top_score(players, round_state)
  players_by_score =
    players.sort_by do |player|
      round_player_score(player, round_state)
    end

  players_by_score.reverse
end

def round_score_display(players, round_state)
  players_by_top_score = players_by_top_score(players, round_state)
  messages = players_by_top_score.map do |player|
    player_name = player_name_with_player_count_awareness(player, players)
    "#{player_name}: #{round_player_score(player, round_state)}"
  end

  display_empty_line
  messages_bordered_display(messages, '=', header: 'Round Scoreboard')
end

def round_score_final_display(winning_player, players)
  display_empty_line
  winning_player_name = player_name_with_player_count_awareness(
    winning_player, players
  )
  messages_bordered_display(
    "#{winning_player_name} won the round!", '*'
  )
end

def end_round?(players, round_state)
  round_winning_player = round_winning_player(players, round_state)

  if round_winning_player.nil?
    puts 'Press enter to continue the round ' \
         "(first to #{round_state[:win_score]} wins)..."
    gets
    false
  else
    round_score_final_display(round_winning_player, players)
    true
  end
end
