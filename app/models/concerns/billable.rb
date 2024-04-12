module Billable
  extend ActiveSupport::Concern

  included do
    include Taxable

    belongs_to :contact
    has_many :line_items, as: :billable

    scope :with_contact, -> { includes(:contact) }

    accepts_nested_attributes_for :line_items, allow_destroy: true

    validate :has_at_least_one_line_item
  end

  def total_amount
    (sales_amount + tax_amount).round(2)
  end

  def sales_amount
    (line_items.map(&:total_price).reduce(:+) || 0.00).round(2)
  end

  private

  def has_at_least_one_line_item
    errors.add(:base, "At least one line item is required") unless line_items.any?
  end
end
