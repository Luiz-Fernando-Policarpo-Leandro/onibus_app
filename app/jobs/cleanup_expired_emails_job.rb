class CleanupExpiredEmailsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    status_waiting = Status.find_by(name: "waiting")&.id
    User.where("created_at < ?", 45.minutes.ago).where(status: status_waiting).delete_all
  end
end
