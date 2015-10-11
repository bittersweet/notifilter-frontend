class Event
  attr_accessor :id

  def initialize(event)
    @id = event["_id"]
    @source = event["_source"]
  end

  def self.find(id)
    doc = $ES.get(index: 'notifilter', id: id)
    new(doc)
  end

  def event_name
    @source["name"]
  end

  def name
    @source["name"]
  end

  def received_at
    Date.parse(@source["received_at"])
  end

  def data
    @source["data"]
  end
end
