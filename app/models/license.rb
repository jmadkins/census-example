class License < ApplicationRecord
  scope :valid, -> { active_and_permanent.or(active_trial) }
  scope :active_and_permanent, -> { where(status: ["approved", "permanent"]) }
  scope :active_trial, -> { where(status: "trial", trial_expires_at: Time.current..) }

  enum status: {
    created: "created",
    trial: "trial",
    approved: "approved",
    expired: "expired",
    permanent: "permanent"
  }, _default: "created"
end
