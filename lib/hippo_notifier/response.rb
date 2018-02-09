module HippoNotifier
  class Response
    def initialize(results_array)
    end
  end
end

# {
#   notifications_sent_successfully: {
#     {
#       service_name: 'twilio',
#       medium: 'sms',
#       message: 'ok'
#     },
#     {
#       service_name: 'action_mailer',
#       medium: 'email',
#       message: 'ok'
#     }
#   }
#   notifications_sent_unsuccessfully: {
#     {
#       service_name: 'pusher',
#       medium: 'in-app',
#       errors: []
#     }
#   }
# }
