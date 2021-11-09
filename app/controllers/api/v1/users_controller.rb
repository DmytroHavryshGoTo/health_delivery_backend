# frozen_string_literal: true

module Api
  module V1
    class UsersController < AdminsController
      skip_before_action :auth_user, only: %i[create]
      skip_before_action :check_admin_access, only: %i[create me index]

      def index
        render json: ::UserSerializer.new(User.all).serializable_hash.to_json
      end

      def update
        result = ::Users::UpdateService.call(update_params.to_h.merge(id: params[:id]).symbolize_keys)

        if result.success?
          head :no_content
        else
          error_response(result.user, :unprocessable_entity)
        end
      end

      def create
        result = ::Users::CreateService.call(*user_params)

        if result.success?
          render json: ::UserSerializer.new(result.user).serializable_hash.to_json
        else
          error_response(result.user, :unprocessable_entity)
        end
      end

      def me
        render json: ::UserSerializer.new(current_user).serializable_hash.to_json
      end

      private

      def user_params
        params.require(%i[first_name last_name email password])
      end

      def update_params
        params.require(:user).permit(%i[first_name last_name email password])
      end
    end
  end
end
