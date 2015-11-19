class EventsController < ApplicationController
  def index
    @page = params[:page].to_i
    @events = Events.new(@page).latest_events
  end

  def show
    @event = Event.find(params[:id])
  end
end
