# frozen_string_literal: true

module Dumps
  class CreateService
    prepend BasicService

    option :user_id

    def call
      initialize_config

      filename = "#{Time.now.strftime('%Y%m%d%H%M%S')}_#{@database}.sql"
      path = "#{Rails.root}/public/uploads/backups/#{filename}"
      cmd = "mysqldump -u #{@username} #{@database} --ignore-table=#{@database}.dumps --ignore-table=#{@database}.user_sessions > #{path}"
      puts cmd
      _output = %x( #{cmd} )

      Dump.create(user_id: user_id, url: path)
    end

    private

    def initialize_config
      config = Rails.configuration.database_configuration
      @host     = config[Rails.env]['host']
      @database = config[Rails.env]['database']
      @username = config[Rails.env]['username']
      @password = config[Rails.env]['password']
    end
  end
end
