# frozen_string_literal: true

module Ads
  class CreateService
    prepend BasicService

    option :name
    option :description
    option :address
    option :user_id

    attr_reader :ad

    def call
      @ad = Ad.new(
        name: @name,
        description: @description,
        address: @address,
        user_id: @user_id
      )

      fail!(@ad.errors) unless @ad.save
    end
  end
end
