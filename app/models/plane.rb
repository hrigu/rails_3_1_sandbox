module ParkedState
  def start
    puts "parked_state: start"
    super
  end
end

module RollingState
  def stop
    puts "rolling_state:stop"
    super
  end

  def force
    puts "rolling_state:force"
    super
  end
end

module FlyingState
  def stop
    puts "flying_state:stop"
    super
  end
end


class Plane
  attr_accessor :id

  state_machine initial: :parked do

    event :start do
      transition :parked => :rolling
    end

    event :stop do
      transition :rolling => :parked
      transition :flying => :parked
    end

    event :force do
      transition :rolling => :flying
    end

    state :parked do
     include ParkedState
    end

    state :rolling do
      def stop
        puts "rolling_state:stop"
        super
      end
      #include RollingState
    end

    state :flying do
      def stop
        puts "flying_state:stop"
        stop
      end
#      include FlyingState
    end
  end

end