class Admin
  attr_reader :game_instances

  def initialize game_instances = {}
    @game_instances = game_instances
  end

  def solved
    result = []
    @game_instances.each do |key, game|
      result << game if game.solved
    end
    result
  end

  def running
    result = []
    @game_instances.each do |key, game|
      puts game
      result << game if game && !game.solved
    end
    result
  end
end