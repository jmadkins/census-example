module FinancialDisclosureReportable
  extend ActiveSupport::Concern

  included do
    belongs_to :reporting_period, optional: true

    before_validation :set_reporting_period

    has_rich_text :memo

    # validates :memo, no_attachments: true
    validates :amount, presence: true
    validates :transaction_date, presence: true

    scope :regular, -> { where(transaction_type: "REGULAR") }
    scope :in_kind, -> { where(transaction_type: "IN_KIND") }

    # TODO: Make this an enum after retiring SystemCodes
    # enum transaction_type: {
    #   regular: "REGULAR",
    #   in_kind: "IN_KIND"
    # }
  end

  def in_kind?
    transaction_type == "IN_KIND"
  end

  def regular?
    transaction_type == "REGULAR"
  end

  def set_reporting_period
    self.reporting_period = ReportingPeriod.as_of_for_universe(transaction_date, universe) if reporting_period.blank?
  end
end
