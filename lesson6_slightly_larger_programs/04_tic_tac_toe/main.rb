# frozen_string_literal: true

# Flowchart: https://app.terrastruct.com/diagrams/2101848647

require_relative 'board_state'
require_relative 'board_display'
require_relative 'players'
require_relative 'winner_detection'

def display_winner(winning_mark, board_state, players)
  board_display(board_state)

  winner = players.select { |player| player[:mark] == winning_mark }.first
  no_computer_players = players.count { |player| player[:is_computer] }.zero?

  if no_computer_players || winner[:is_computer] then puts "#{winner[:name]} won!"
  else puts "You won! (#{winner[:mark]})"
  end
end

def end_game_winner?(board_state, players)
  winning_mark = winning_mark(board_state)
  unless winning_mark.nil?
    display_winner(winning_mark, board_state, players)
    return true
  end

  false
end

def display_tie(board_state)
  board_display(board_state)
  puts 'Tie!'
end

def end_game_tie?(board_state)
  if board_full?(board_state)
    display_tie(board_state)
    return true
  end

  false
end

def end_game?(board_state, players)
  return true if end_game_winner?(board_state, players)
  return true if end_game_tie?(board_state)

  false
end

def redraw(board_state, players)
  board_display(board_state, include_move_values: true)
  players_display(players)
  puts
end

def play_and_end_game?(board_state, players)
  end_game = false

  players.each do |player|
    if player[:is_computer] then computer_move!(player[:mark], board_state)
    else player_move!(player, board_state)
    end

    redraw(board_state, players)

    end_game = end_game?(board_state, players)
    break if end_game
  end

  end_game
end

def start_game(players)
  board_state = board_state_create
  redraw(board_state, players)

  loop do
    end_game = play_and_end_game?(board_state, players)
    break if end_game
  end
end

def play
  players = welcome_players

  loop do
    start_game(players)

    print "\nPlay again? (Y/N) "
    break puts 'Cheerio!' unless gets.strip.downcase.chars.first == 'y'
  end
end

play
