namespace :rabbitmq do
    desc "Create rabbitmq 'jobs.db_create' queue and binds it to the 'app.jobs' exchange"
    task setup_queue: :environment do
      require 'bunny'
      connection = Bunny.new({ host: 'rabbitmq' })
      connection.start
      channel = connection.create_channel
      exchange = channel.fanout("app.jobs")
      queue = channel.queue('jobs.db_create', durable: true)
      queue.bind(exchange.name)
      connection.close
    end
  
  end
  