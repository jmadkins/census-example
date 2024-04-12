# Workflows and triggers
module Workflowable
  extend ActiveSupport::Concern

  included do
    has_many :workflow_triggers, as: :triggerable
    has_many :workflows, through: :workflow_triggers
  end
end
