class EventsController < ApplicationController
  def index
    @events = EventData.latest_events
  end

  def show
    @event = Event.find(params[:id])
  end
end
