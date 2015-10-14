class EventData
  # Query ES for all known applications
  def self.applications
    body = {
      size: 0,
      aggs: {
        applications: {
          terms: {
            field: "application",
            size: 0,
            order: {
              "_term" => "asc"
            }
          }
        }
      }
    }
    result = $ES.search(index: 'notifilter', body: body)
    result["aggregations"]["applications"]["buckets"].map{ |bucket| bucket["key"] }
  end

  # Query ES for all known event names
  # This does an aggregation with size 0 to make sure we get every result.
  # TODO: Consider making nested aggregations for application name as well so
  # we have a tree of applications + known event names
  def self.event_names
    body = {
      size: 0,
      aggs: {
        names: {
          terms: {
            field: "name",
            size: 0,
            order: {
              "_term" => "asc"
            }
          }
        }
      }
    }
    result = $ES.search(index: 'notifilter', body: body)
    result["aggregations"]["names"]["buckets"].map{ |bucket| bucket["key"] }
  end

  # Return all known event names
  # It's a bit long-winded but because ES stores mappings for every field it
  # will ever index we can just get this data out of the mappings.
  def self.all_keys
    mapping = $ES.indices.get_mapping(index: 'notifilter')
    mapping['notifilter']['mappings']['event']['properties']['data']['properties'].keys
  end

  # Return latest 10 events
  def self.latest_events
    body = {
      size: 10,
      sort: [
        received_at: { order: "desc" }
      ]
    }
    result = $ES.search(index: 'notifilter', body: body)
    result["hits"]["hits"].map{ |event| Event.new(event) }
  end

  # Return specific event
  def self.event(id)
    $ES.search(index: 'notifilter', body: body)
  end

  # Return count of events per hour
  #
  # ES only returns values between the first bucket that matches documents and
  # the last one. Because of `min_doc_count` it will show 0 for days that have
  # no data, but only if that date falls in between a bucket that has data.
  #
  # https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations-bucket-datehistogram-aggregation.html#_scripts
  #
  # Possible solution: generate date ranges in ruby as well and merge that with
  # data received from ES.
  def self.event_counts_per_hour
    body = {
      size: 0,
      query: {
        range: {
          received_at: {
            gte: "now-7d"
          }
        }
      },
      aggs: {
        event_counts_per_hour: {
          date_histogram: {
            field: "received_at",
            interval: "hour",
            format: "yyyy-MM-dd HH:mm:ss",
            min_doc_count: 0 # fill in the blanks
          }
        }
      }
    }
    result = $ES.search(index: 'notifilter', body: body)
    result["aggregations"]["event_counts_per_hour"]["buckets"]
  end
end
