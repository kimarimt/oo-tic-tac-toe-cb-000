class TicTacToe
  WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(move)
    index = move.to_i - 1
    return index
  end

  def move(index, token = "X")
    @board[index] = token
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0, 8) && position_taken?(index) == false
  end

  def turn_count
    counter = 0

    @board.each do |position|
      if !(position == " " || position.nil?)
        counter += 1
      end
    end

    return counter
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Please enter 1-9: "
    position = gets.strip
    position = input_to_index(position)

    if valid_move?(position)
      move(position, current_player)
      display_board
    else
      turn
    end
  end

  def won?
    combo = 0
      while combo < WIN_COMBINATIONS.length
        current_combo = WIN_COMBINATIONS[combo]

        win1 = current_combo.all? { |position| @board[position] == "X" }
        win2 = current_combo.all? { |position| @board[position] == "O" }

        if win1 == true || win2 == true
          return current_combo
        end

        combo += 1
      end
  end

  def full?
    @board.all? {|index| index == "X" || index == "O"}
  end

  def draw?
    full? && !(won?)
  end

  def over?
    draw? || won?
  end

  def winner?
    if won?
      @board[won?[0]]
    end
  end

  def play
    while !(over?)
      turn
    end

    if won?
      puts "Congratulations #{winner?}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
