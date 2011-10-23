class GuessStrategy

  def make_guess(solution_disposer)
    raise "No possible solutions found" if solution_disposer.possible_solutions.size == 0
    r = Random.rand solution_disposer.possible_solutions.size
    guess = solution_disposer.possible_solutions.to_a[r]
  end
end