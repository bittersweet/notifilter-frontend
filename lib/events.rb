class Events
  EVENTS_PER_PAGE = 10

  def initialize(page = 0)
    @page = page
  end

  def latest_events
    body = {
      from: from,
      size: EVENTS_PER_PAGE,
      sort: [
        received_at: { order: "desc" }
      ]
    }
    result = $ES.search(index: 'notifilter', body: body)
    result["hits"]["hits"].map{ |event| Event.new(event) }
  end

  private

  # Translate the page param to make sure we skip the previous pages
  def from
    @page * EVENTS_PER_PAGE
  end
end
