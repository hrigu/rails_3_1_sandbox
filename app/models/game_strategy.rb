class GameStrategy

  attr_reader :type
  attr_reader :master, :solver, :board

  def initialize game_spec, type
    game_spec = game_spec
    @type = type
    @board = Board.new game_spec.colors, game_spec.size_of_code
  end

  def start
  end

  def possible_solutions
    []
  end

  def enter_code code
    raise "doesn't make sense for #{name}'"
  end

end

class ComputerAgainstHumanStrategy < GameStrategy

  def initialize game_spec, type
    super game_spec, type
    @master = ComputerMaster.new board
    @solver = HumanSolver.new game_spec.colors, game_spec.size_of_code
    @master.build_secret_code
  end

  def guess guess
    @solver.current_guess = guess
    @board.guess = guess
    unless @master.solved
      eval = @master.evaluate guess
      @board.eval = eval
    else
      @solver = nil #to save memory
    end
  end

end

class ComputerAgainstComputerStrategy < GameStrategy

  def initialize game_spec, type
    super game_spec, type
    @master = ComputerMaster.new board
    @solver = ComputerSolver.new game_spec.colors, game_spec.size_of_code
    @master.build_secret_code
  end                                                 ^

  def start
    super
  end

  def guess args = nil
    current_guess = solver.make_guess

    board.guess = current_guess

    unless @master.solved
      eval = @master.evaluate current_guess
      board.eval = eval
      @solver.reduce_solutions board.current_guess
    else
      @solver = nil #to save memory
    end
  end

  def possible_solutions
    @solver.possible_solutions
  end


end

class HumanAgainstComputerStrategy < GameStrategy

  def start
    super
    @solver = ComputerSolver.new @game_spec.colors, @game_spec.size_of_code
    @current_guess = @solver.make_guess
  end

  def guess args = nil
    @current_guess = @solver.make_guess

    puts @current_guess.inspect
    @game_spec.solved = @mastermind.guess @current_guess
    unless @game_spec.solved
      @solver.reduce_solutions @mastermind.current_guess
    else
      @solver = nil #to save memory
    end
  end

  def possible_solutions
    @solver.possible_solutions
  end
end