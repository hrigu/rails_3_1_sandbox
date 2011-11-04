class TrafficLight

  state_machine initial: :stop do

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
end

