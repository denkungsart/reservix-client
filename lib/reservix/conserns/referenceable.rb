module Reservix
  module Referenceable
    private

    def fetch_reference(name)
      references.dig(name)&.first || {}
    end
  end
end
