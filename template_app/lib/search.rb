require 'elasticsearch'

module Bookbinder
  module Search
    def self.call(env)
      client = Elasticsearch::Client.new log: true, url: JSON.parse(ENV['VCAP_SERVICES'])['searchly'][0]['credentials']['uri']
      query = env['QUERY_STRING'].split('&').detect { |s| s =~ /\Aq=/ }.split('=').last
      results = client.search q: query
      [200, {'Content-Type' => 'application/json'}, [results.to_json]]
    end
  end
end
