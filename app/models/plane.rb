class Plane
  attr_accessor :id

  state_machine initial: :parked do

    event :start do
      transition :parked => :rolling
    end


    event :stop do
      transition :rolling => :parked
      transition :flying => :crashed
    end

    event :accelerate do
      transition :rolling => :flying
    end

    event :sinking do
      transition :flying => :rolling
    end
  end
end