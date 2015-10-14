class StatisticsController < ApplicationController
  def overview
    @events = EventData.event_counts_per_hour
  end
end
