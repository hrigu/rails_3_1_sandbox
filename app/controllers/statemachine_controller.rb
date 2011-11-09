$plane_next_id ||=0;
$plane_instances ||= {}

class StatemachineController < ApplicationController


  def self.add_plane plane
    id = $plane_next_id
    $plane_instances[id] = plane
    plane.id = id
    $plane_next_id += 1
  end

  def self.find_plane id
    $plane_instances[id]
  end

  def index
    @plane = Plane.new
    StatemachineController.add_plane @plane
    session[:plane_id] = @plane.id
    render_page
  end

  def start
    find
    @plane.start
    render_page
  end

  def stop
    find
    @plane.stop
    render_page
  end

  def force
    find
    @plane.force
    render_page
  end

  private
  def render_page
      respond_to do |format|
      format.html { render "index" }
      end

  end

  def find
    @plane = StatemachineController.find_plane(session[:plane_id])
  end

end
