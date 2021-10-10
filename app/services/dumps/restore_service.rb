# frozen_string_literal: true

module Dumps
  class RestoreService
    prepend BasicService

    option :id

    def call
      initialize_config

      cmd = "mysql -u #{@username} #{@database} < #{@dump.url}"
      puts cmd
      _output = %x( #{cmd} )
    end

    private

    def initialize_config
      config = Rails.configuration.database_configuration
      @database = config[Rails.env]['database']
      @username = config[Rails.env]['username']
      @dump = Dump.find(id)
    end
  end
end
