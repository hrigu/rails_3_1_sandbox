require "spec_helper"
require File.expand_path(Rails.root) + '/lib/mastermind/solver/computer_solver'
require File.expand_path(Rails.root) + '/lib/mastermind/mastermind'


def init_solver(possible_colors)
  ComputerSolver.new possible_colors, 4
end

describe "Compute the possible Solutions" do

  context "For one color" do
    it "should give one solution" do
      possible_colors = ["a"]
      solver = init_solver(possible_colors)
      solver.possible_solutions.size.should == 1
      solver.possible_solutions[0].should == ["a", "a", "a", "a"]
    end
  end

  context "For two color" do
    it "should give 16 solution" do
      possible_colors = ["a", "b"]
      solver = init_solver(possible_colors)
      solver.possible_solutions.size.should == 16
      solver.possible_solutions[0].should == ["a", "a", "a", "a"]
      solver.possible_solutions[1].should == ["a", "a", "a", "b"]
      solver.possible_solutions[2].should == ["a", "a", "b", "a"]
      solver.possible_solutions[3].should == ["a", "a", "b", "b"]
      solver.possible_solutions[15].should == ["b", "b", "b", "b"]
    end
  end

  context "For four color" do
    it "should give 256 solution" do
      possible_colors = ["a", "b", "c", "d"]
      solver = init_solver(possible_colors)
      solver.possible_solutions.size.should == 256
      solver.possible_solutions[0].should == ["a", "a", "a", "a"]
      solver.possible_solutions[1].should == ["a", "a", "a", "b"]
      solver.possible_solutions[2].should == ["a", "a", "a", "c"]
      solver.possible_solutions[3].should == ["a", "a", "a", "d"]
      solver.possible_solutions[4].should == ["a", "a", "b", "a"]
    end
  end

  context "For 6 color" do
    it "should give 1296 solution" do
      possible_colors = ["a", "b", "c", "d", "e", "f"]
      solver = init_solver(possible_colors)
      solver.possible_solutions.size.should == 1296
    end
  end
end

describe "Reduce the possible solutions. Initialized with 3 colors" do
  describe "and 2 positions" do

    before(:each) do
      @solver = ComputerSolver.new %w[a b c], 2
      @solver.possible_solutions.size.should == 9
    end
    context "one black" do
      context "guess is [a a] and bewertung is [1,0]" do
        it "should be" do
          guess = Guess.new %w[a a]
          guess.num_of_blacks = 1
          @solver.reduce_solutions guess
          @solver.possible_solutions.should == [%w[a b], %w[a c], %w[b a], %w[c a]]

          #@solver.possible_solutions.each do |s|
          #  puts s.inspect
          #end
          @solver.possible_solutions.size.should == 4

        end
      end
    end
    context "one white" do
      context "guess is [a b] and bewertung is [0, 1]" do
        it "should be" do
          guess = Guess.new %w[a b]
          guess.num_of_whites = 1
          @solver.reduce_solutions guess
          @solver.possible_solutions.size.should == 2
          @solver.possible_solutions.sort.should == [%w[b c], %w[c a]]
        end
      end
    end
  end
  describe "and 3 positions" do
    before(:each) do
      @solver = ComputerSolver.new %w[a b c], 3
      @solver.possible_solutions.size.should == 27
    end
    context "one black" do
      context "guess is [a b c]" do
        it "should be" do
          guess = Guess.new %w[a b c]
          guess.num_of_blacks = 1
          @solver.reduce_solutions guess
          @solver.possible_solutions.should == [%w[a a a], %w[b b b], %w[c c c]]
          @solver.possible_solutions.size.should == 3
        end
      end
      context "guess is [a b b]" do
        it "should be" do
          guess = Guess.new %w[a b b]
          guess.num_of_blacks = 1
          @solver.reduce_solutions guess
          @solver.possible_solutions.should == [["a", "a", "a"], ["a", "a", "c"], ["a", "c", "a"], ["a", "c", "c"], ["c", "b", "c"], ["c", "c", "b"]]

          @solver.possible_solutions.each do |s|
            puts s.inspect
          end
          @solver.possible_solutions.size.should == 6
        end
      end
      context "guess is [a a b]" do
        it "should be" do
          guess = Guess.new %w[a a b]
          guess.num_of_blacks = 1
          @solver.reduce_solutions guess
          #@solver.possible_solutions.should == [["a", "a", "a"], ["a", "a", "c"], ["a", "c", "a"], ["a", "c", "c"], ["c", "b", "c"], ["c", "c", "b"]]
          @solver.possible_solutions.size.should == 6
        end
      end
    end
    context "[1 1]" do
      context "guess is [a b c]" do
        it "should be" do
          guess = Guess.new %w[a b c]
          guess.num_of_blacks = 1
          guess.num_of_whites = 1
          @solver.reduce_solutions guess
          @solver.possible_solutions.should include %W[a a b]
          @solver.possible_solutions.should include %W[a c a]
          @solver.find_all(["a"]).size.should == 2
          @solver.find_all([nil, "a"]).size.should == 2
          @solver.find_all([nil, nil, nil]).size.should == 6
          @solver.possible_solutions.size.should == 6
        end
      end
    end
  end
end

describe "Reduce the possible solutions. Initialized with 6 colors and 4 positions" do

  before(:each) do
    @solver = init_solver(%w[a b c d e f])
  end

  after (:each) do
    @solver.possible_solutions.each do |p|
      #   puts p.join " "
      p.size.should == 4
    end

  end
  context "For four blacks" do
    it "should have only one solution" do
      guess = Guess.new %w[a b c d]
      guess.num_of_blacks = 4
      @solver.reduce_solutions guess
      @solver.possible_solutions.size.should == 1
      @solver.possible_solutions[0].should == guess.code
    end
  end
  context "For three blacks" do
    it "should have 20 solutions" do
      guess = Guess.new %w[a b c d]
      guess.num_of_blacks = 3
      @solver.reduce_solutions guess
      @solver.possible_solutions.size.should == 20
      #stichprobe
      @solver.possible_solutions.should include %w[a b c e]
      @solver.possible_solutions.should_not include %w[a b c d]

    end
  end

  context "For two blacks" do
    it "should have 98 solutions" do
      guess = Guess.new %w[b b c d]
      guess.num_of_blacks = 2
      guess.num_of_whites = 0
      @solver.reduce_solutions guess
      @solver.possible_solutions.size.should == 98
      #stichprobe
      @solver.possible_solutions.should include %w[b a c f]
      @solver.possible_solutions.should include %w[b b e e]
      @solver.possible_solutions.should_not include %w[a b c d]
    end
  end
  context "For one black" do
    it "should have 182 solutions" do
      guess = Guess.new %w[b b c d]
      guess.num_of_blacks = 1
      guess.num_of_whites = 0
      @solver.reduce_solutions guess
      @solver.possible_solutions.size.should == 182
      @solver.possible_solutions.should include %w[b a a a]
      @solver.possible_solutions.should_not include %w[b a d e] #one pos, one color that is already shown
      @solver.possible_solutions.should_not include %w[a b e d]
    end
  end

end

describe "Reduce the possible solutions for n whites and zero blacks" do
  before(:each) do
    @solver = init_solver(%w[a b c d e f])
  end
  after (:each) do
    @solver.possible_solutions.each do |p|
      #puts p.join " "
      p.size.should == 4
    end
  end

  context "For four whites, no duplicates" do
    it "should have 9 solution" do
      guess = Guess.new %w[a b c d]
      guess.num_of_whites = 4
      @solver.reduce_solutions guess
      @solver.possible_solutions.size.should == 9
      @solver.possible_solutions.should_not include guess.code
      @solver.possible_solutions.should_not include %w[a c b d]
      #stichprobe
      @solver.possible_solutions.should include %w[b a d c]
    end
  end
  context "For four whites with two duplicates" do
    it "should have 1 solution" do
      guess = Guess.new %w[a a c c]
      guess.num_of_whites = 4
      @solver.reduce_solutions guess
      @solver.possible_solutions.each do |p|
        puts p.join " "
        p.size.should == 4
      end
      @solver.possible_solutions.size.should == 1
      @solver.possible_solutions.should_not include guess.code
      @solver.possible_solutions.should include %w[c c a a]
    end
  end
  context "For three whites" do
    it "should have 136 solution" do
      guess = Guess.new %w[a b c d]
      guess.num_of_whites = 3
      @solver.reduce_solutions guess
      @solver.possible_solutions.size.should == 136
      @solver.possible_solutions.should_not include guess.code
      @solver.possible_solutions.should_not include %w[b c d a]
      #stichprobe
      @solver.possible_solutions.should include %w[b c a e]
      @solver.possible_solutions.should include %w[b c a c]
    end
  end

  context "For two whites" do
    it "should have 312 solution" do
      guess = Guess.new %w[a b c d]
      guess.num_of_whites = 2
      @solver.reduce_solutions guess
      @solver.possible_solutions.size.should == 312
      @solver.possible_solutions.should_not include guess.code
      @solver.possible_solutions.should_not include %w[a c b d]

      @solver.possible_solutions.should_not include %w[c d a b]
      #stichprobe
      @solver.possible_solutions.should include %w[e f a b]
    end
  end
  context "For one white" do
    it "should have 152 solution" do
      guess = Guess.new %w[a b c d]
      guess.num_of_whites = 1
      @solver.reduce_solutions guess
      @solver.possible_solutions.size.should == 152
      @solver.possible_solutions.should_not include guess.code
      @solver.possible_solutions.should_not include %w[a b e f]
      @solver.possible_solutions.should_not include %w[c a b f]

      #stichprobe
      @solver.possible_solutions.should include %w[b e b b]
    end
  end

  context "For one white with duplicate" do
    it "should contain a specific solution" do
      guess = Guess.new %w[b a a c]
      guess.num_of_whites = 1
      @solver.reduce_solutions guess
      @solver.possible_solutions.size.should == 276
      @solver.possible_solutions.should include %w[f c c e]
    end
  end

end

describe "Reduce the possible solutions for 3 whites and 1 blacks" do
  before(:each) do
    @solver = init_solver(%w[a b c d e f])
  end
  after (:each) do
    @solver.possible_solutions.each do |p|
      #puts p.join " "
      p.size.should == 4
    end
  end

  context "For three whites and one black" do
    it "should have 8 solution" do
      guess = Guess.new %w[a b c d]
      guess.num_of_blacks = 1
      guess.num_of_whites = 3
      @solver.reduce_solutions guess
      @solver.possible_solutions.size.should == 8
      @solver.possible_solutions.should_not include guess.code
      @solver.possible_solutions.should_not include %w[b a d c]
      #stichprobe
      @solver.possible_solutions.should include %w[a c d b]
      @solver.possible_solutions.should include %w[c b d a]
    end
  end
  context "For zero whites and zero black" do
    it "should have only one solution" do
      guess = Guess.new %w[a b c d]
      guess.num_of_blacks = 0
      guess.num_of_whites = 0
      @solver.reduce_solutions guess
      @solver.possible_solutions.size.should == 16
      @solver.possible_solutions.should_not include guess.code
      @solver.possible_solutions.should_not include %w[a f f f]
      #stichprobe
      @solver.possible_solutions.should include %w[e f e f]
      @solver.possible_solutions.should include %w[f f f f]
    end
  end
end


