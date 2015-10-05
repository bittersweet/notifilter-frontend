require 'patron'
require 'elasticsearch'

es_host = "127.0.0.1"

if ENV['WERCKER']
  es_host = ENV['ELASTICSEARCH_PORT_9200_TCP_ADDR']
end

if Rails.env.test?
  log = false
else
  log = true
end
$ES = Elasticsearch::Client.new(host: "#{es_host}:9200", log: log)
