class CleanupExpiredEmailsJob < ApplicationJob
  queue_as :low

  def perform
    status_waiting = Status.waiting.id
    User.where("created_at < ?", 45.minutes.ago).where(status: status_waiting).delete_all
  end
end
