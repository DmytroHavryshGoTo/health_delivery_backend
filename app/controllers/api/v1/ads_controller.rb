# frozen_string_literal: true

module Api
  module V1
    class AdsController < ApplicationController
      before_action :check_help_access, only: :create

      def index
        render json: ::AdSerializer.new(ads.order(completed: :asc, created_at: :desc), include: [:user]).serializable_hash.to_json
      end

      def show
        ad = Ad.find(params[:id])
        render json: ::AdSerializer.new(ad, include: [:user]).serializable_hash.to_json
      end

      def update
        ad = current_user.ads.find(params[:id])
        if ad.update(update_params)
          render json: { message: 'updated' }
        else
          error_response(ad, :bad_request)
        end
      end

      def create
        result = ::Ads::CreateService.call(ad_params.to_h.merge({ user_id: current_user.id }).deep_symbolize_keys)

        if result.success?
          head :created
        else
          error_response(result.ad, :unprocessable_entity)
        end
      end

      private

      def ad_params
        params.require(:ad).permit(:name, :description, :address)
      end

      def update_params
        params.permit(:completed)
      end

      def ads
        @ads ||= params[:search].present? ? Ad.where("name LIKE :s OR description LIKE :s", s: "%#{params[:search]}%") : Ad.all
      end

      def check_help_access
        error_response(I18n.t(:wrong_type, scope: 'users'), :forbidden) unless current_user.need_help?
      end
    end
  end
end