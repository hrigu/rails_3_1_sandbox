class GuessStrategy

  def make_guess(solution_disposer)
    r = Random.rand solution_disposer.possible_solutions.size
    solution_disposer.possible_solutions.to_a[r]
  end
end