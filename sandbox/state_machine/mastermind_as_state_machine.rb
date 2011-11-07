class MastermindAsStateMachine

  attr_reader :secret_code, :current_guess, :current_evaluation

  state_machine initial: :start do

    event :secret_code_set do
      transition :start => :wait_for_guess
    end

    event :guess do
      transition :wait_for_guess => :wait_for_evaluation
    end

    event :evaluate do
      transition :wait_for_evaluation => :wait_for_guess
    end

    event :cracked do
      transition :wait_for_evaluation => :finished
    end

    event :cancel do
      transition all - [:start, :finished] => :start
    end

    event :new_game do
      transition :finished => :start
    end

    state :start do
      def secret_code= secret_code
        @secret_code = secret_code
        self.secret_code_set
      end
    end

    state :wait_for_guess do
      def guess= guess
        @current_guess = guess
        self.guess
      end
    end

    state :wait_for_evaluation do
      def evaluation= evaluation
        @current_evaluation = evaluation
        if (evaluation[0] == 4)
          self.cracked
        else
          self.evaluate
        end
      end
    end
  end


end