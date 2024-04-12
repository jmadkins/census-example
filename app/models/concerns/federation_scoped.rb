module FederationScoped
  extend ActiveSupport::Concern

  included do
    belongs_to :federation, touch: true
  end
end
