#
# Simulates a traffic light.
# The behaviors (color method) are defined in the states. This method becomes the method of the TrafficLight when
# the state becomes active (Becaus the state is an ancestor of TrafficLight)
#
# t = TrafficLight.new
# t.color ==> red
#
class TrafficLight

  state_machine initial: :stop do

    before_transition do |light, transition|

      light.boom "before transition from #{transition.from} to #{transition.to}"
    end

    after_transition do |light, transition|
      p transition
      light.boom "after transition"
    end

    event :cycle do
      transition :stop => :proceed, :proceed => :caution, :caution => :stop
    end

    state :stop do
      def color
        "red"
      end
    end

    state :proceed do
      def color
        "green"
      end
    end

    state :caution do
      def color
        "orange"
      end
    end
  end

  def cycle
    super
  end

  def boom what
    puts "#{what}!"
  end
end

