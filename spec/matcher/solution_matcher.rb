require 'rspec'

RSpec::Matchers.define :contain do |code|

  match do |solutions|
    ok = false
    solutions.each do |solution|
      if solution.code == code
        ok = true
        break
      end
    end
    ok
  end

  failure_message_for_should do |solutions|
    "no solution found with the code == #{code}"
  end

  failure_message_for_should_not do |player|
    "There is at least one solution with the code == #{code}"
  end

  description do
    "looks if there is a solution with a code that matches to the given code"
  end
end

RSpec::Matchers.define :correlate do |expected_colors|
  match do |color_set|
    color_set.to_a should =~ expected_colors
    #ok = true
    #expected_colors.each do |color|
    #  unless color_set.include? color
    #    ok = false
    #    break
    #  end
    #end
    #ok
  end

end
