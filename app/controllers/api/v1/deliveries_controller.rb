# frozen_string_literal: true

module Api
  module V1
    class DeliveriesController < ApplicationController
      skip_before_action :auth_user, only: %i[update damage]

      def index
        deliveries = current_user.deliveries.order(id: :desc) 
        deliveries = deliveries.limit(params[:limit].to_i) if params[:pagy].present?
        deliveries = deliveries.where(delivery_status: params[:status]) if params[:status].present?
        render json: ::DeliverySerializer.new(deliveries, include: [:drugs]).serializable_hash.to_json
      end

      def show
        delivery = current_user.deliveries.find(params[:id])
        render json: ::DeliverySerializer.new(delivery, include: [:drugs]).serializable_hash.to_json
      end

      def destroy
        delivery = current_user.deliveries.preparing_to_deliver.find(params[:id])
        delivery.destroy
      end

      def update
        delivery = Delivery.find(params[:id])
        delivery.update(delivery_status: params[:status].to_sym)
        route = delivery.route
        return if city.blank?

        route.each do |station|
          station[:passed] = true if station[:current]
          station[:current] = true if station[:name] == city['city']
        end

        delivery.update(lat: params[:lat], lon: params[:lon], route: route)
      end

      def create  
        result = ::Deliveries::CreateService.call(delivery_params.to_h.merge({ user_id: current_user.id }).deep_symbolize_keys)

        if result.success?
          head :created
        else
          error_response(result.user, :unprocessable_entity)
        end
      end

      def damage
        delivery = Delivery.find(params[:id])
        drug = delivery.drugs.find_by(container_id: params[:container_id])
        return if city.blank?

        route = delivery.route
        route.each do |st|
          if st[:name] == city['city']
            st[:damages] ||= []
            st[:damages] << { message: params[:message], drug_id: drug.id }
          end
        end
        delivery.update(route: route)
      end

      def search
        delivery = Delivery.find_by(ttn: params[:ttn])
        raise ActiveRecord::RecordNotFound if delivery.blank?

        render json: ::DeliverySerializer.new(delivery, include: [:drugs]).serializable_hash.to_json
      end

      private

      def city
        return @_city if @_city.present?

        cities_file = File.open(Rails.root.join('app/lib/worldcities.json'))
        json_cities = JSON.load(cities_file)

        @_city = json_cities.find { |c| c['lat'] == params[:lat] && c['lng'] == params[:lon] }
      end

      def delivery_params
        params.permit(
          delivery: [
            :name,
            :estimated_delivery_date,
            route: [:name]
          ],
          drugs: %i[name quantity container_id max_humidity min_humidity max_temperature min_temperature]
        )
      end
    end
  end
end
