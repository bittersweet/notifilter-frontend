class EventsController < ApplicationController
  def index
    @events = EventData.latest_events
  end
end
