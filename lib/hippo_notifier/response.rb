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
      output = {
        notifications_sent_successfully: [],
        notifications_sent_unsuccessfully: []
      }

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
