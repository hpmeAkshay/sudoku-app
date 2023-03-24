class SudokuSolverController < ApplicationController
  def solve
    board = params[:data]
    board = board.map { |row| row.map { |cell| cell.nil? ? 0 : cell } }
    solved_puzzle = solve_board(board)
    render json: { solution: solved_puzzle }
  end

  private

  GRID_SIZE=9

def is_number_in_row(board, number, row)
    for i in 0...GRID_SIZE do
        if board[row][i]==number
            return true
        end
    end
    return false
end

def is_number_in_column(board, number, column)
    for i in 0...GRID_SIZE do
        if board[i][column]==number
            return true
        end
    end
    return false
end

def is_number_in_box(board, number, row, column)
    local_box_row= row-row % 3
    local_box_column= column - column % 3

    for i in local_box_row...local_box_row+3 do
        for j in local_box_column...local_box_column+3 do
            if board[i][j]==number
                return true
            end
        end
    end
    return false
end

def is_valid_placement(board, number, row, column)

    return !is_number_in_row(board, number, row) &&
            !is_number_in_column(board, number, column) &&
            !is_number_in_box(board, number, row, column)
end

def solve_board(board)
   
    for row in 0...GRID_SIZE do
        for column in 0...GRID_SIZE do
            if board[row][column]==0 
                for number_to_try in 1..GRID_SIZE
                    if is_valid_placement(board, number_to_try, row, column)
                        board[row][column]=number_to_try
                        if solve_board(board)
                            return board
                        else
                            board[row][column]=0
                        end
                    end
                end
                return false
            end
        end
    end
    return board
end
end
