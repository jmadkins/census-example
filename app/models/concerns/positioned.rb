module Positioned
  extend ActiveSupport::Concern

  included do
    scope :ordered, -> { order(:position) }
  end
end
