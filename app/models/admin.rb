class Admin
  attr_reader :game_instances

  def initialize game_instances = {}
    @game_instances = game_instances
  end

  def solved
    result = []
    @game_instances.each do |key, value|
      result << value if value.solved
    end
    result
  end

  def running
    result = []
    @game_instances.each do |key, value|
      puts value
      result << value if value && !value.solved
    end
    result
  end

  def not_started
    result = []
    @game_instances.each do |key, value|
      result << value unless value.mastermind
    end
    result
  end
end