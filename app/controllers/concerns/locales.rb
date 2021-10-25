# frozen_string_literal: true

module Locales
  extend ActiveSupport::Concern

  included do
    before_action :set_locale
  end

  protected

  def set_locale
    I18n.locale = user_locale
  rescue I18n::InvalidLocale
    I18n.locale = I18n.default_locale
  end

  def user_locale
    params[:locale] || http_head_locale || I18n.default_locale
  end

  def http_head_locale
    request.env['HTTP_ACCEPT_LANGUAGE']
  end
end
