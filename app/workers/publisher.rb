class Publisher
  def self.publish(queued_job)
    connection = Bunny.new(hostname: "rabbitmq:5672").start
    work_queue = connection.create_channel.queue('jobs', durable: true)
    work_queue.publish(queued_job.to_json)
    connection.close
  end
end
