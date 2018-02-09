module HippoNotifier
  class Response
    attr_reader :data

    def initialize(results_array)
      @results_array = results_array.compact
      @data = return_output
    end

    def successful
      @data[:notifications_sent_successfully]
    end

    def unsuccessful
      @data[:notifications_sent_unsuccessfully]
    end

    private

    def return_output
      output = {}

      @results_array.each do |result|
        if result[:message] == 'ok'
          output[:notifications_sent_successfully] << result
        else
          output[:notifications_sent_unsuccessfully] << result
        end
      end

      output
    end
  end
end

# {
#   notifications_sent_successfully: [
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
#   ]
#   notifications_sent_unsuccessfully: [
#     {
#       service_name: 'pusher',
#       medium: 'in-app',
#       errors: []
#     }
#   ]
# }
