# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ApiErrors
  include Auth
  include Locales
end
