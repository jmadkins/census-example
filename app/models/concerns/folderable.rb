module Folderable
  extend ActiveSupport::Concern

  included do
    include UniverseScoped

    belongs_to :folder, optional: true

    validates :folder, same_universe_association: true, if: -> { folder.present? }
  end
end
