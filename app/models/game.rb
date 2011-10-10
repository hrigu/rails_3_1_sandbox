class Game
  attr_accessor :master, :solver


  def initialize master, solver
    @master, @solver = master, solver
  end
  def model_name
    self.class.name
  end

  def method_missing(sym, *args, &block)
    puts sym
    p *args
    p &block
    super
  end

end