module UniverseScoped
  extend ActiveSupport::Concern

  included do
    # Universe is actually not optional, but we not do want to generate a SELECT query to verify the universe is
    # there every time. We get this protection for free because of `Current.universe_or_raise!` and through FK constraints.
    belongs_to :universe, optional: true

    # default_scope { where(universe: Current.universe_or_raise!) }
  end
end
