require 'patron'
require 'elasticsearch'

es_host = ENV['NOTIFILTER_ESHOST'] || "127.0.0.1"
es_port = ENV['NOTIFILTER_ESPORT'] || "9200"

host_port = "#{es_host}:#{es_port}"

$ES = Elasticsearch::Client.new(host: host_port)
