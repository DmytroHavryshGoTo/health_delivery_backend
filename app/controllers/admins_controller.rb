# frozen_string_literal: true

class AdminsController < ApplicationController
  before_action :check_admin_access

  private

  def check_admin_access
    error_response(I18n.t(:denied, scope: 'admins.access'), :forbidden) unless current_user.admin?
  end
end
