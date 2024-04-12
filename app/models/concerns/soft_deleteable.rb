module SoftDeleteable
  extend ActiveSupport::Concern

  included do
    default_scope { where(deleted_at: nil) }
    scope :deleted, -> { where.not(deleted_at: nil) }
  end

  def soft_destroy!
    mark_as_deleted
    save!
  end
  alias_method :destroy!, :soft_destroy!
  alias_method :delete!, :soft_destroy!

  def soft_destroy
    mark_as_deleted
    save
  end
  alias_method :destroy, :soft_destroy
  alias_method :delete, :soft_destroy

  def deleted?
    deleted_at.present?
  end

  def destroyed?
    deleted?
  end

  def mark_as_deleted
    self.deleted_at ||= Time.current
  end

  def mark_as_undeleted
    self.deleted_at = nil
  end
end
