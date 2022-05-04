# frozen_string_literal: true

module Deliveries
  class CreateService
    prepend BasicService

    option :delivery do
      option :name
      option :route
      option :estimated_delivery_date
    end

    option :drugs
    option :user_id
    option :ad_id, optional: true

    attr_reader :parcel
    attr_reader :user
    attr_reader :ad

    def call
      @user = User.find(user_id)
      @ad = Ad.find_by(id: ad_id)
      ActiveRecord::Base.transaction do
        create_delivery
        create_drugs
        track_delivery
      end
    end

    private

    def create_delivery      
      @parcel = ::Delivery.new({
        user_id: user_id,
        ad_id: (ad.present? && ad.delivery.blank?) ? ad_id : nil,
        estimated_delivery_date: Date.parse(delivery.estimated_delivery_date),
        route: optimized_route,
        name: delivery.name
      })      
      fail!(parcel.errors) unless parcel.save!
    end

    def optimized_route
      ::Deliveries::CalculateRouteService.call(delivery.route).optimized_route
    end

    def create_drugs
      drugs.each do |drug|
        parcel.drugs.create!(drug.to_h.deep_symbolize_keys)
      end
    end

    def track_delivery
      if ad.present? && ad.delivery.blank?
        ad.user.trackable_deliveries.create!(delivery_id: parcel.id)
      end
      user.trackable_deliveries.create!(delivery_id: parcel.id)
    end
  end
end
