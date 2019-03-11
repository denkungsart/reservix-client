require 'reservix/version'
require 'open-uri'
require 'json'

require 'reservix/concerns/referenceable'

require 'reservix/event'
require 'reservix/event_group'
require 'reservix/genre'
require 'reservix/venue'
require 'reservix/url_builder'

# Reservix API Ruby wrapper
# API spec at https://developer.reservix.de
module Reservix
  class << self
    attr_accessor :api_key
  end

  # Client is a main class to iteract with Reservix API
  # returns Ruby objects converted from the JSON respose
  class Client
    def events(options = {})
      build_objects(send_request('event', options), Event)
    end

    def event_groups(options = {})
      build_objects(send_request('eventgroup', options), EventGroup)
    end

    def genres(options = {})
      build_objects(send_request('genre', options), Genre)
    end

    private

    def build_objects(data, klass)
      data.map { |e| klass.new(e) }
    end

    def send_request(path, options = {})
      url = UrlBuilder.call(path, options)
      JSON.parse(open(url.to_s).read).dig('data')
    end
  end
end
