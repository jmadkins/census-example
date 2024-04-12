module ContactScoped
  extend ActiveSupport::Concern

  included do
    belongs_to :contact
    has_one :universe, through: :contact

    scope :with_contact, -> { includes(:contact) }
  end
end
