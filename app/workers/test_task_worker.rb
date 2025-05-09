class TestTaskWorker
  include Sidekiq::Worker

  def perform
    # This task runs every minute and logs a message
    Rails.logger.info "TestTaskWorker: Task executed at #{Time.now}"
  end
end
