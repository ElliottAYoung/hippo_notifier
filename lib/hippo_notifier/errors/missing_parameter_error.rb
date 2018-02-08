module HippoNotifier
  module Errors
    class MissingParameterError < ArgumentError
      def initialize(missing_params)
        message = "You are missing one or more critical parameters. Missing params: #{missing_params.join(', ')}"
        super message
      end
    end
  end
end
