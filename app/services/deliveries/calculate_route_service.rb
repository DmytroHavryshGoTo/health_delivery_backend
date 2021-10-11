# frozen_string_literal: false

module Deliveries
  class CalculateRouteService
    prepend BasicService

    param :route
    attr_reader :optimized_order, :optimized_route

    def call
      get_google_direactions
      build_optimized_route
    end

    private

    def get_google_direactions
      waypoints = route[1...route.size-1].map { |station| "#{station[:lat]}%2C#{station[:lon]}" }.join('|')
      origin = "#{route.first[:lat]}%2C#{route.first[:lon]}"
      destination = "#{route.last[:lat]}%2C#{route.last[:lon]}"

      query = 'https://maps.googleapis.com/maps/api/directions/json'
      query << "?origin=#{origin}&destination=#{destination}"
      query << "&waypoints=optimize%3Atrue%7C#{waypoints}&mode=driving&language=en-US"
      query << "&key=#{ENV['GOOGLE_MAPS_KEY']}"

      url = URI(query)
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)

      @optimized_order = JSON.parse(https.request(request).body)['routes'][0]['waypoint_order']
    end

    def build_optimized_route
      @optimized_route = route.dup
      optimized_order.each_with_index do |value, idx|
        @optimized_route[idx+1] = route[value+1]
      end
    end
  end
end
