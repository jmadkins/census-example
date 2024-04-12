module Payable
  extend ActiveSupport::Concern

  DEFAULT_PAYMENT_TERMS = 14.days

  included do
    has_many :payments, as: :payable
    has_many :refunds, as: :refundable
  end

  def total_amount_paid
    payments.sum(:amount).round(2)
  end

  def total_balance_due
    (total_amount - total_amount_paid).round(2)
  end
end
