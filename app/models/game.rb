require File.dirname(__FILE__) + '/game_strategy'

class Game

  #only to load the classes...TODO: find better way
  Mastermind.new


  COMPUTER_MENSCH = "Computer-Mensch"
  COMPUTER_COMPUTER = "Computer-Computer"
  MENSCH_COMPUTER = "Mensch-Computer"

  #states
  WAIT_FOR_SECRET_CODE = :wait_for_secret_code
  WAIT_FOR_NEW_GUESS = :wait_for_new_guess
  WAIT_FOR_EVALUATION = :wait_for_evaluation
  SOLVED = :solved



  attr_reader:game_spec

  def initialize game_spec

    @game_spec = game_spec

    if game_spec.master == "Computer"
      if game_spec.solver == "Mensch"
        @strategy = ComputerAgainstHumanStrategy.new game_spec, COMPUTER_MENSCH
      else
        @strategy = ComputerAgainstComputerStrategy.new game_spec, COMPUTER_COMPUTER
      end
    else
      if game_spec.solver == "Mensch"
        raise MastermindError, "Mensch vs Mensch nicht implementiert. Holt euch ein Mastermind aus der Ding-Welt!"
      else
        @strategy = HumanAgainstComputerStrategy.new game_spec, MENSCH_COMPUTER
      end
    end
    GameHolder.add(self)
  end


  #actions
  def put info = nil
    @strategy.put info
  end

  #end aktionen

  def board
    @strategy.board
  end

  def master
    @strategy.master
  end

  def solver
    @strategy.solver
  end

  def type
    @strategy.type
  end

  def secret_code
    @strategy.master.secret_code
  end

  def possible_solutions
    @strategy.possible_solutions
  end

  def state
    @strategy.state
  end

  def solved
    @strategy.master.solved
  end

  def id
    @game_spec.id
  end

end
