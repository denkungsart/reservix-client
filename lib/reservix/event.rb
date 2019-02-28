module Reservix
  class Event < OpenStruct
    include Referenceable

    def event_group
      EventGroup.new(fetch_reference('eventgroup'))
    end

    def genre
      Genre.new(fetch_reference('genre'))
    end

    def venue
      Venue.new(fetch_reference('venue'))
    end
  end
end
