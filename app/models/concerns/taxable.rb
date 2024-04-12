module Taxable
  extend ActiveSupport::Concern

  included do
    belongs_to :tax_rate, optional: true
  end

  def taxable?
    contact.present? && contact.taxable?
  end

  def taxed?
    tax_rate.present?
  end

  def tax_amount
    return 0 unless taxed?

    line_item_total = line_items.where(taxable: true).map(&:total_price).reduce(:+) || 0.00
    (line_item_total * taxable_rate).round(2)
  end

  def taxable_rate
    tax_rate.rate / 100.0
  end
end
