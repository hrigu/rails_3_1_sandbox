module StatemachineHelper
  def links

    links = []
    @plane.state_events.each do |event|
       links << {name: event.to_s, path: send("statemachine_#{event.to_s}_path")}
    end
    p links
    links
  end
end
