require 'reservix/version'
require 'open-uri'
require 'json'

require 'reservix/conserns/referenceable'

require 'reservix/event'
require 'reservix/event_group'
require 'reservix/genre'
require 'reservix/venue'

# Reservix API Ruby wrapper
# API spec at https://developer.reservix.de
module Reservix
  API_URL = 'https://api.reservix.de/'.freeze
  API_VERSION = '1'.freeze

  class << self
    attr_accessor :api_key
  end

  # Client is a main class to iteract with Reservix API
  # returns Ruby objects converted from the JSON respose
  class Client
    def events
      build_objects(send_request('event'), Event)
    end

    def event_groups
      build_objects(send_request('eventgroup'), EventGroup)
    end

    def genres
      build_objects(send_request('genre'), Genre)
    end

    private

    def build_objects(data, klass)
      data.map { |e| klass.new(e) }
    end

    def send_request(path)
      url = "#{API_URL}/#{API_VERSION}/sale/#{path}?api-key=#{Reservix.api_key}"
      JSON.parse(open(url).read).dig('data')
    end
  end
end
