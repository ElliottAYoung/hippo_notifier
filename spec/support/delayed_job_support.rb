class TestJobHandler
  def self.find_by(val)
    val[:batch_id] == 0 ? nil : true
  end

  def self.enqueue(job, hash)
  end
end

module Jobs
  class BatchedNotificationJob
    def initialize(batch)
    end
  end
end

Delayed::Job = TestJobHandler
