# frozen_string_literal: true

module Ssl
  class UpdateService
    prepend BasicService

    def call
      commands = {
        remove_old_certs: 'rm certs/*',
        create_new_certs: ENV['CEATE_CERTS_CMD'],
        move_certs: ENV['MOVE_CERTS_CMD'],
        restart_nginx: ENV['RESTART_NGINX_CMD']
      }
      commands.each do |name, command|
        puts name
        %x( #{command} )
      end
    end
  end
end
