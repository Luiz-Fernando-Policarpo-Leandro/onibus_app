class CleanupExpiredEmailsJob < ApplicationJob
  queue_as :low

  def perform(*args)
    Rails.logger.info "AQUI"

    status_waiting = Status.find_by(name: "waiting")&.id
    User.where("created_at < ?", 45.minutes.ago).where(status: status_waiting).delete_all
  end
end
