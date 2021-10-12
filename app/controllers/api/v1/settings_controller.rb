# frozen_string_literal: true

module Api
  module V1
    class SettingsController < AdminsController
      before_action :check_admin_access

      def dumps
        render json: ::DumpSerializer.new(Dump.all.order(id: :desc)).serializable_hash.to_json
      end

      def create_dump
        ::Dumps::CreateService.call(user_id: current_user.id)
      end

      def restore_dump
        ::Dumps::RestoreService.call(id: params[:id])
      end

      def update_ssl
        ::Ssl::UpdateService.call
      end
    end
  end
end
