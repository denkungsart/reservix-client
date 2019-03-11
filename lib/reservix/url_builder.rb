module Reservix
  class UrlBuilder
    API_URL = 'https://api.reservix.de'.freeze
    API_VERSION = '1'.freeze

    class << self
      def call(path, options)
        url = URI("#{API_URL}/#{API_VERSION}/sale/#{path}")
        formatted_options = options
          .yield_self { |hsh| apify_options(hsh) }
          .yield_self { |hsh| datify_options(hsh) }
        url.query = URI.encode_www_form(formatted_options)
        url
      end

      def apify_options(params)
        params.merge('api-key' => Reservix.api_key)
      end

      def datify_options(params)
        date_fields = %w[startdate eventdate]

        params.each_with_object({}) do |(key, value), hsh|
          if date_fields.include?(key) && value.is_a?(Date)
            hsh[key] = value.strftime('%Y-%m-%d')
          else
            hsh[key] = value
          end
        end
      end
    end
  end
end
