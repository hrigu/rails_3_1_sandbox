module StatemachineHelper

  def picture_url
    "/assets/statemachine.png"
  end

  def links
    links = []
    @plane.state_events.each do |event|
       links << {name: event.to_s, path: statemachine_path(event: event)}
    end
    links
  end
end
