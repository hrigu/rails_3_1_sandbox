$game_instances ||= {}
$game_spec_instances ||= {}
$game_next_id ||=0;


class GameHolder
  def self.add_spec spec
    id = $game_next_id
    $game_spec_instances[id] = spec
    spec.id = id
    $game_next_id += 1
  end

  def self.find_spec id
    $game_spec_instances[id]
  end

  def self.add game
    id = game.id
    $game_instances[id] = game
  end

  def self.find id
    $game_instances[id]
  end


  def self.delete id
    $game_instances.each do |key, value|
      puts key
    end
    $game_instances.delete id
    $game_instances.each do |key, value|
      puts key
    end
  end

end