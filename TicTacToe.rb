class GameBoard
    attr_accessor :board

    def initialize
        @board = [[" ", " ", " "],
                  [" ", " ", " "],
                  [" ", " ", " "]]
    end

    def board_layout
        puts ["[1]","[2]","[3]"].join(",")
        puts ["[4]","[5]","[6]"].join(",")
        puts ["[7]","[8]","[9]"].join(",")
    end

    def board_state(symbol, cell_row, cell_column)
        self.board[cell_row][cell_column] = symbol if self.board != " "
        check = horizontal_check()
        check = vertical_check()
        check = diagonal_check()

        display_board()

        return check
    end

    def display_board
        puts [@board[0][0]," | ",@board[0][1]," | ",@board[0][2]].join()
        puts "-----------"
        puts [@board[1][0]," | ",@board[1][1]," | ",@board[1][2]].join()
        puts "-----------"
        puts [@board[2][0]," | ",@board[2][1]," | ",@board[2][2]].join()
    end

    private
    def horizontal_check
        check = false
        i = 0

        while check == false && i < 3
            if @board[i][0]==@board[i][1] && @board[i][1]==@board[i][2] && @board[i][0]!=" "
                check = true
            end
            i+=1
        end

        return check
    end

    def vertical_check
        check = false
        i = 0

        while check == false && i < 3
            if @board[0][i]==@board[1][i] && @board[1][i]==@board[2][i] && @board[0][i]!=" "
                check = true
            end
            i+=1
        end

        return check
    end

    def diagonal_check
        check = false
        i = 0

        if @board[0][0]==@board[1][1] && @board[1][1]==@board[2][2] && @board[0][0]!=" "
            check = true
        elsif @board[0][2]==@board[1][1] && @board[1][1]==@board[2][0] && @board[2][0]!=" "
            check = true
        end
        
        return check
    end


end

class Player
    attr_accessor :player

    def initialize(player)
        @player = player
    end

    def make_a_move(move)
        case move.to_i
        when 1
            cell_row = 0
            cell_column = 0
        when 2
            cell_row = 0
            cell_column = 1
        when 3
            cell_row = 0
            cell_column = 2
        when 4
            cell_row = 1
            cell_column = 0
        when 5
            cell_row = 1
            cell_column = 1
        when 6
            cell_row = 1
            cell_column = 2
        when 7
            cell_row = 2
            cell_column = 0
        when 8
            cell_row = 2
            cell_column = 1
        when 9
            cell_row = 2
            cell_column = 2
        else
            puts "I don't know what to do with this..."
            cell_row = nil
            cell_column = nil
        end

        return [cell_row, cell_column, self.player]
    end

end

class Game
    attr_accessor :game

    def initialize (player1_name, player2_name)
        @game = "In Progress"
        @game_board = GameBoard.new
        @player1 = Player.new(player1_name)
        @player2 = Player.new(player2_name)

        @game_board.board_layout
    end

    def play_game(move, player_turn)
        cell = @player1.make_a_move(move) if player_turn%2!= 0
        cell = @player2.make_a_move(move) if player_turn%2 == 0

        outcome = @game_board.board_state("O", cell[0], cell[1]) if cell[2] == @player1.player
        outcome = @game_board.board_state("*", cell[0], cell[1]) if cell[2] == @player2.player
        puts  "Congrats!!#{cell[2]} has won." if outcome == true
        return outcome
    end

        
end

def play
    puts "Enter Player One Name for 'O':"
    player1_name = gets.chomp
    puts "Enter Player Two Name for '*':"
    player2_name = gets.chomp

    new_game = Game.new(player1_name, player2_name)

    outcome = false
    i = 1 
    
    while outcome == false && i < 10
        puts "Enter #{player1_name} move:" if i%2 != 0
        puts "Enter #{player2_name} move:" if i%2 == 0
        move = gets.chomp

        outcome  = new_game.play_game(move, i)
        
        i+=1
    end

    puts "Sorry, the match was draw :(" if i==10
end

play()
