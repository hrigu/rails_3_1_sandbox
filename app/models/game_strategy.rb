class GameStrategy

  attr_reader :type, :state
  attr_reader :master, :solver, :board

  def initialize game_spec, type
    game_spec = game_spec
    @type = type
    @board = Board.new game_spec.colors, game_spec.size_of_code
  end

  def possible_solutions
    []
  end

  def enter_code code
    raise "doesn't make sense for #{name}'"
  end


end

##
#  master: computer
#  solver: human
##
class ComputerAgainstHumanStrategy < GameStrategy

  def initialize game_spec, type
    super game_spec, type
    @master = ComputerMaster.new board
    @solver = HumanSolver.new game_spec.colors, game_spec.size_of_code
    @master.build_secret_code
    @state = Game::WAIT_FOR_NEW_GUESS
  end

  def put guess
    if @state == Game::WAIT_FOR_NEW_GUESS
      @solver.current_guess = guess
      @board.guess = guess
      eval = @master.evaluate guess
      @board.eval = eval
      if @master.solved
        @state = Game::SOLVED
        @solver = nil #to save memory
      end
    elsif @state == Game::SOLVED
      #do nothing
    else
      raise "could not understand state #{@state}"
    end
  end
end
##
#  master: computer
#  solver: computer
##
class ComputerAgainstComputerStrategy < GameStrategy

  def initialize game_spec, type
    super game_spec, type
    @master = ComputerMaster.new board
    @solver = ComputerSolver.new game_spec.colors, game_spec.size_of_code
    @master.build_secret_code
    @state = Game::WAIT_FOR_NEW_GUESS
  end

  def put args = nil
    if @state == Game::WAIT_FOR_NEW_GUESS
      current_guess = solver.make_guess
      board.guess = current_guess
      eval = @master.evaluate current_guess
      board.eval = eval
      if @master.solved
        @state = Game::SOLVED
        @solver = nil #to save memory
      else
        @solver.reduce_solutions board.current_guess
      end
    elsif @state == Game::SOLVED
      #do nothing
    else
      raise "could not understand state #{@state}"
    end
  end

  def possible_solutions
    @solver.possible_solutions
  end


end

##
#  Master: human
#  Solver: computer
##
class HumanAgainstComputerStrategy < GameStrategy


  def initialize game_spec, type
    super game_spec, type
    @master = HumanMaster.new board
    @solver = ComputerSolver.new game_spec.colors, game_spec.size_of_code
    @state = Game::WAIT_FOR_SECRET_CODE
  end


  def put args
    if (@state == Game::WAIT_FOR_SECRET_CODE)
      @master.secret_code = args
      current_guess = @solver.make_guess
      @board.guess = current_guess
      @state = Game::WAIT_FOR_EVALUATION
    elsif @state == Game::WAIT_FOR_EVALUATION
      blacks = 0
      whites = 0
      args.each do |color|
        blacks += 1 if color == "black"
        whites += 1 if color == "white"
      end
      @master.evaluation = [blacks, whites]
      eval = @master.evaluate @board.current_guess
      @board.eval = eval
      if @master.solved
        @state = Game::SOLVED
        @solver = nil #to save memory
      else
        @solver.reduce_solutions @board.current_guess
        current_guess = @solver.make_guess
        @board.guess = current_guess
        @state = Game::WAIT_FOR_EVALUATION
      end
    elsif (@state == Game::SOLVED)
      #do nothing
    else
      raise "could not understand state #{@state}"
    end
  end

  def possible_solutions
    @solver.possible_solutions
  end

end