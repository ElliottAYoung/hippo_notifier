class PusherTestClient
  def initialize(args = {})
  end

  def trigger(channel, event, adapter)
  end
end

Pusher::Client = PusherTestClient
