# frozen_string_literal: true

class SendgridMailer
  FROM = SendGrid::Email.new(email: 'healthdelivery.apz@gmail.com')
  SUBJECT = 'Delivery updated'

  def self.send_notification(to, name, current_station, current_status)
    # I18n.locale = :uk
    subject = I18n.t(:subject, scope: 'mailer.notifications.delivery_update')
    content = SendGrid::Content.new(
      type: 'text/plain',
      value: I18n.t(:value, scope: 'mailer.notifications.delivery_update', name: name, station: current_station, status: current_status)
    )
    
    mail = SendGrid::Mail.new(FROM, SUBJECT, SendGrid::Email.new(email: to), content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)

    puts response.status_code
    puts response.body
    puts response.headers
  end
end
