class EventData
  # Query ES for all known event names
  # This does an aggregation with size 0 to make sure we get every result.
  def self.event_names
    body = {
      size: 0,
      aggs: {
        keys: {
          terms: {
            field: "key",
            size: 0,
            order: {
              "_term" => "asc"
            }
          }
        }
      }
    }
    result = $ES.search(index: 'notifilter', body: body)
    result["aggregations"]["keys"]["buckets"].map{ |bucket| bucket["key"] }
  end

  # Return all known event names
  # It's a bit long-winded but because ES stores mappings for every field it
  # will ever index we can just get this data out of the mappings.
  def self.all_keys
    mapping = $ES.indices.get_mapping(index: 'notifilter')
    mapping['notifilter']['mappings']['event']['properties']['data']['properties'].keys
  end
end
